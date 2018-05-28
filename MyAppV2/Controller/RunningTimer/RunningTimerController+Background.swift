//
//  RunningTimerController+Background.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 07/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension RunningTimerController {
    
    func setupObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground(noti:)), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(noti:)), name: .UIApplicationWillEnterForeground, object: nil)
        
    }
    
    
    @objc func pauseWhenBackground(noti: Notification) {
        
        guard let timer = self.timer else { return }
        timer.invalidate()
        
        let shared = UserDefaults.standard
        shared.set(Date(), forKey: "savedTime")
    }
    
    @objc func willEnterForeground(noti: Notification) {
        if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
            
            let components = self.getTimeDifference(startDate: savedDate)
            
            guard let minutes = components.minute else { return }
            guard let seconds = components.second else { return }
            
            print("\(minutes) minutes and \(seconds) seconds")
            
            let differenceCount = minutes * 60 + seconds
            
            self.count -= CGFloat(differenceCount)
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
            
        }
    }
    
    func getTimeDifference(startDate: Date) -> DateComponents {
        
        let calendar = Calendar.current
        
        return calendar.dateComponents([.minute, .second], from: startDate, to: Date())
    }
    
}
