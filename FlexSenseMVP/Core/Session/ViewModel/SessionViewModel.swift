//
//  SessionViewModel.swift
//  FlexSenseMVP
//
//  Created by Arpan Das on 8/8/25.
//

import Foundation

struct FlexPair: Identifiable {
    var id = UUID()
    var count: Int
    var flex: Double
}

class SessionViewModel: ObservableObject {
    static let shared = SessionViewModel()
    
    var pair1: FlexPair?
    var pair2: FlexPair?
    
    @Published var flex1Array: [FlexPair] = []
    @Published var flex2Array: [FlexPair] = []
    
    @Published var count = 0
    @Published var analyticReadyCount = 0
    @Published var analyticSwingCount = 0
    @Published var analyticFollowCount = 0
    
    @Published var userCriticalFlex1: Double = 0
    @Published var userCriticalFlex2: Double = 0
    
    @Published var flex1Value: Double = 0
    @Published var flex2Value: Double = 0
    @Published var accl: Double = 0
    @Published var gx: Double = 0
    @Published var gy: Double = 0
    @Published var gz: Double = 0
    
    @Published var ScaledFlex1: Double = 0
    @Published var ScaledFlex2: Double = 0
    
    @Published var liveAcclScale: Double = 0
    @Published var avgAccl: Double = 0
    
    @Published var activePhase: String = ""
    
    @Published var readyUF: Double = 0
    @Published var readyLF: Double = 0
    @Published var readyCF: Double = 0
    @Published var readyACC: Double = 0
    
    @Published var swingUF: Double = 0
    @Published var swingLF: Double = 0
    @Published var swingCF: Double = 0
    @Published var swingACC: Double = 0
    
    @Published var followUF: Double = 0
    @Published var followLF: Double = 0
    @Published var followCF: Double = 0
    @Published var followACC: Double = 0
    
    func SplitString(_ data: String) {
        flex1Value = Double(data.split(separator: ",")[0]) ?? 0
        flex2Value = Double(data.split(separator: ",")[1]) ?? 0
        accl = Double(data.split(separator: ",")[2]) ?? 0
        gx = Double(data.split(separator: ",")[3]) ?? 0
        gy = Double(data.split(separator: ",")[4]) ?? 0
        gz = Double(data.split(separator: ",")[5]) ?? 0
    }
    
    func calculateAcclScale() {
        liveAcclScale = (accl - 1) * 100
        if liveAcclScale < 0 {
            liveAcclScale = 0
        }
        let summation = avgAccl * Double(count) + accl
        count += 1
        avgAccl = summation / Double(count)
    }
    
    func getFlex() {
        ScaledFlex1 = ((flex1Value - 100) * 0.225) - 4
        pair1 = FlexPair(count: count, flex: ScaledFlex1)
        ScaledFlex2 = ((flex2Value) * 0.225) - 7
        pair2 = FlexPair(count: count, flex: ScaledFlex2)
        flex1Array.append(pair1 ?? FlexPair(count: count, flex: 0))
        if flex1Array.count > 50 {
            flex1Array.removeFirst()
        }
        flex2Array.append(pair2 ?? FlexPair(count: count, flex: 0))
        if flex2Array.count > 50 {
            flex2Array.removeFirst()
        }
    }
    
    func extractActivePhase() {
        if accl > 1{
            if gz > 300 && gz < 550 {
                activePhase = "Follow through"
            } else if gy > -300 && gy < -100 {
                activePhase = "Ready"
            } else if gy > 100 && gy < 250 {
                activePhase = "Swing"
            }
        } else {
            activePhase = ""
        }
    }
    
    func GetReadyAnalytics() {
        let LFSummation = readyLF * Double(analyticReadyCount) + ScaledFlex2
        let UFSummation = readyUF * Double(analyticReadyCount) + ScaledFlex1
        let ACCSummation = readyACC * Double(analyticReadyCount) + accl
        analyticReadyCount += 1
        readyLF = LFSummation / Double(analyticReadyCount)
        readyUF = UFSummation / Double(analyticReadyCount)
        readyACC = ACCSummation / Double(analyticReadyCount)
        if (flex1Value > userCriticalFlex1 || flex2Value > userCriticalFlex2) {
            readyCF += 1
        }
    }
    
    func GetSwingAnalytics() {
        let LFSummation = swingLF * Double(analyticSwingCount) + ScaledFlex2
        let UFSummation = swingUF * Double(analyticSwingCount) + ScaledFlex1
        let ACCSummation = swingACC * Double(analyticSwingCount) + accl
        analyticSwingCount += 1
        swingLF = LFSummation / Double(analyticSwingCount)
        swingUF = UFSummation / Double(analyticSwingCount)
        swingACC = ACCSummation / Double(analyticSwingCount)
        if (flex1Value > userCriticalFlex1 || flex2Value > userCriticalFlex2) {
            swingCF += 1
        }
    }
    
    func GetFollowAnalytics() {
        let LFSummation = followLF * Double(analyticFollowCount) + ScaledFlex2
        let UFSummation = followUF * Double(analyticFollowCount) + ScaledFlex1
        let ACCSummation = followACC * Double(analyticFollowCount) + accl
        analyticFollowCount += 1
        followLF = LFSummation / Double(analyticFollowCount)
        followUF = UFSummation / Double(analyticFollowCount)
        followACC = ACCSummation / Double(analyticFollowCount)
        if (flex1Value > userCriticalFlex1 || flex2Value > userCriticalFlex2) {
            followCF += 1
        }
    }
}
