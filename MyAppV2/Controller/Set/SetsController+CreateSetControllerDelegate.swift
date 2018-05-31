//
//  SetsController+CreateSetControllerDelegate.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension SetsController: CreateSetControllerDelegate {
    func didAddSet(set: Set) {
        sets.append(set)
        let indexPath = IndexPath(row: sets.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        guard let trainingIsDone = trainingIsDone else { return }
        
        if !trainingIsDone && UserDefaults.standard.value(forKey: "automaticTimerSwitchIsOn") as? Bool == true {
//            tabBarController?.selectedIndex = 2
            let runningTimerController = RunningTimerController()
            runningTimerController.modalPresentationStyle = .overFullScreen
            runningTimerController.timerValue = CGFloat(90)
            present(runningTimerController, animated: true, completion: nil)
        }
    }
    
    func didEditSet(set: Set) {
        guard let row = sets.index(of: set) else { return }
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }    
}
