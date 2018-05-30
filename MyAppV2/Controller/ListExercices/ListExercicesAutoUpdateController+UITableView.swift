//
//  ListExercicesAutoUpdateController+UITableView.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ListExercicesAutoUpdateController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: listExercicesCellId)
    }
    
    //MARK: DATA SOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = fetchResultsController.sections?[section].numberOfObjects {            
            return numberOfRows
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listExercicesCellId, for: indexPath)

        let exercice = fetchResultsController.object(at: indexPath)
        cell.textLabel?.text = "\(exercice.name ?? "")"
        cell.accessoryType = selectedExercices.contains(exercice) ? .checkmark : .none
        
        return cell        
    }
    
    
    //MARK: DELEGATE
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchResultsController.sections {
            return sections[section].name
        }
        return fetchResultsController.sectionIndexTitles[section]
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if training != nil { return UISwipeActionsConfiguration(actions: []) }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
            
            let exercice = self.fetchResultsController.object(at: indexPath)
            _ = CoreDataManager.shared.deleteExercice(exercice: exercice)
            
            success(true)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        
        
        return config
    }
    
    
    
    //MARK: TO DO
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        
        let exercice = fetchResultsController.object(at: indexPath)
        
        if let index = selectedExercices.index(of: exercice) {
            selectedExercices.remove(at: index)
            cell.accessoryType = .none
        } else {
            selectedExercices.append(exercice)
            cell.accessoryType = .checkmark
        }
    
        return nil
    }
}









