//
//  BLEManager.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/8/25.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    static let shared = BLEManager()
    
    var centralManager: CBCentralManager!
    
    @Published var isScanning = false
    @Published var isDeviceFound = false
    @Published var discoveredPeripherals: [CBPeripheral] = []
    @Published var connectedPeripheral: CBPeripheral?
    
    @Published var latestSensorData: String = ""
    //latestSensorData = "UpperFlex,LowerFlex,R.Accel,Gx,Gy,Gz"
    
    let espServiceUUID = CBUUID(string: "12345678-1234-5678-1234-56789ABCDEF0")
    let espCharacteristicUUID = CBUUID(string: "ABCDEF01-1234-5678-1234-56789ABCDEF0")
    
    private var dataCharacteristic: CBCharacteristic?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScan() {
        guard centralManager.state == .poweredOn else {
            print("Cannot start scan — Bluetooth is not powered on.")
            return
        }
        print("Starting BLE scan for NRf module service...")
        isScanning = true
        discoveredPeripherals.removeAll()
        centralManager.scanForPeripherals(withServices: [espServiceUUID], options: nil)
    }

    func stopScan() {
        isScanning = false
        centralManager.stopScan()
        print("Stopped BLE scan.")
    }

    func connect(to peripheral: CBPeripheral) {
        print("Connecting to \(peripheral.name ?? "Unknown")...")
        connectedPeripheral = peripheral
        peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
        isDeviceFound = false
    }

    func disconnect() {
        if let peripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            connectedPeripheral = nil
            dataCharacteristic = nil
        }
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is powered on.")
            startScan()
        case .poweredOff: print("Bluetooth is powered off.")
        case .unauthorized: print("Bluetooth unauthorized.")
        case .unsupported: print("Bluetooth unsupported.")
        case .resetting: print("Bluetooth resetting.")
        case .unknown: print("Bluetooth state unknown.")
        @unknown default:
            print("Unhandled Bluetooth state.")
        }
    }

    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {

        if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
            if let serviceUUIDs = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] {
                print("\(peripheral.name ?? "Unknown") advertises: \(serviceUUIDs)")
                if serviceUUIDs.contains(espServiceUUID) {
                    print("Matches NRf Service UUID")
                    isDeviceFound = true
                }
            }
            DispatchQueue.main.async {
                self.discoveredPeripherals.append(peripheral)
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown")")
        connectedPeripheral = peripheral
        peripheral.discoverServices([espServiceUUID])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                print("Discovered service: \(service.uuid)")
                if service.uuid == espServiceUUID {
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("Found characteristic: \(characteristic.uuid)")
                if characteristic.uuid == espCharacteristicUUID {
                    dataCharacteristic = characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                    print("Subscribed to data notifications.")
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        guard characteristic.uuid == espCharacteristicUUID,
              let value = characteristic.value,
              let stringData = String(data: value, encoding: .utf8) else {
            print("Invalid characteristic value or UUID mismatch.")
            return
        }
        DispatchQueue.main.async {
            self.latestSensorData = stringData
        }
    }
}
