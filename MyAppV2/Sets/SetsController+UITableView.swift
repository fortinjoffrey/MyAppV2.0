//
//  SetsController+UITableView.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension SetsController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        
        tableView.register(RepsWeightCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    // MARK: Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }
    
    // MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepsWeightCell
        
        let set = sets[indexPath.row]
        
        switch exercice?.category {
        case "Poids libres / Machines":
//            cell.textLabel?.text = "\(set.repetitions) REPS || \(set.weight) KGS"
            cell.set = set
        case "Cardio":
            print(set.duration)
            cell.textLabel?.text = "\(set.duration / 60 % 60) MIN || \(set.speed) KM / H"
        case "Poids du corps":
            cell.textLabel?.text = "\(set.repetitions)"
        case "Gainage":
            cell.textLabel?.text = "\(set.duration / 60 % 60) MIN \(set.duration % 60) SEC"
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
        
    }
    
    // MARK: Swipe Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
        
            let set = self.sets[indexPath.row]
            
            if CoreDataManager.shared.deleteSet(set: set) {
                self.sets.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
            }
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
