//
//  TrainingsAutoUpdateController+UITableView.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 27/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension TrainingsAutoUpdateController {
    
    func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.register(TrainingCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none        
    }
 
    // MARK: Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = fetchResultsController.sectionIndexTitles[section]
//        return label
//    }
    
    // MARK: Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections![section].numberOfObjects
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // MARK: Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrainingCell
        
        let training = fetchResultsController.object(at: indexPath)
        
        cell.training = training
        
        return cell
    }
    
    // MARK: Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
            
            let training = self.fetchResultsController.object(at: indexPath)
            
            _ = CoreDataManager.shared.deleteTraining(training: training)
            success(true)
            
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Modifier") { (action, view, success) in
            
            let createTrainingController = CreateTrainingController()
            let navController = UINavigationController(rootViewController: createTrainingController)
            
            let training = self.fetchResultsController.object(at: indexPath)
            
            createTrainingController.training = training
            
            self.present(navController, animated: true, completion: nil)
            success(true)
        }
        editAction.backgroundColor = .darkBlue
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
        
    }
    
    // MARK: Did select row at
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let training = fetchResultsController.object(at: indexPath)
        
        let exercicesController = ExercicesController()
        exercicesController.training = training
        navigationController?.pushViewController(exercicesController, animated: true)
        
    }
    
}
