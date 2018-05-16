//
//  ExercicesController+UITableView.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ExercicesController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = exercices[indexPath.row].name
        
        if exercices[indexPath.row].isDone {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let exercice = exercices[indexPath.row]
        
        let setsController = SetsController()
        setsController.exercice = exercice
        setsController.trainingIsDone = training?.isDone
        setsController.delegate = self
        
        navigationController?.pushViewController(setsController, animated: true)
        return nil
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let exercice = exercices[indexPath.row]
//
//        let setsController = SetsController()
//        setsController.exercice = exercice
//        setsController.trainingIsDone = training?.isDone
//        setsController.delegate = self
//
//        navigationController?.pushViewController(setsController, animated: true)
//    }
    
    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .lightBlue
        label.textColor = .darkBlue
        label.textAlignment = .center
        label.text = "Exercices"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK: Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Pas d'exercices enregistrés"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return exercices.count > 0 ? 0 : 150
    }
    
    
}
