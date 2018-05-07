//
//  ExercicesControllerDelegate.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ExercicesController: CreateExerciceControllerDelegate {
   
    func didAddExercice(exercice: Exercice) {
        exercices.append(exercice)
        let indexPath = IndexPath(row: exercices.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .top)
    }
    
    func didEditExercice(exercice: Exercice) {
        guard let row = exercices.index(of: exercice) else { return }
        exercices[row] = exercice
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }    
}

extension ExercicesController: SetsControllerDelegate {
    func didFinishExercice(exercice: Exercice) {
        guard let row = exercices.index(of: exercice) else { return }
        exercices[row] = exercice        
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    
    
    
}
