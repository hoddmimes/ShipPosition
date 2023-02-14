//
//  HandyTimer.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-01.
//

import Foundation


class HandyTimer {
    private var timer: Timer?
    var onFire: (() -> Void)?
    
    var isRunning: Bool {
        timer != nil && timer!.isValid
    }
    
    @objc
    fileprivate func handleTimerEvent() {
        onFire?()
    }
    
    func start(withTimeInterval timeInterval: TimeInterval,
               repeats: Bool = true,
               onFire: @escaping () -> Void) {
        guard !isRunning else { return }
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(handleTimerEvent),
                                     userInfo: nil, repeats: repeats)
        self.onFire = onFire
    }
        
    func stop() {
        timer?.invalidate()
        timer = nil
        onFire = nil
    }
}
 
