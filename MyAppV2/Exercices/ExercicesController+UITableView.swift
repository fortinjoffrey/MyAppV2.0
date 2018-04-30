//
//  ExercicesController+UITableView.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ExercicesController {
    
    func setupTableView() {
        
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = exercices[indexPath.row].name            
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
            
            let exerciceToDelete = self.exercices[indexPath.row]
            
            if CoreDataManager.shared.deleteExercice(exercice: exerciceToDelete) {
                self.exercices.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            success(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Modifier") { (action, view, success) in
            
            let createExerciceController = CreateExerciceController()
            createExerciceController.delegate = self
            createExerciceController.training = self.training
            createExerciceController.exercice = self.exercices[indexPath.row]
            let navController = UINavigationController(rootViewController: createExerciceController)
            success(true)
            self.present(navController, animated: true, completion: nil)
            
            
        }
        editAction.backgroundColor = .darkBlue
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    
    
}
