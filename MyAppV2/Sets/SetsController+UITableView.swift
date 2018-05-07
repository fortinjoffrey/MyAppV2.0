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
        
        tableView.register(RepsWeightCell.self, forCellReuseIdentifier: cellIds[0])
        tableView.register(CardioCell.self, forCellReuseIdentifier: cellIds[1])
        tableView.register(BodyweightCell.self, forCellReuseIdentifier: cellIds[2])
        tableView.register(GainageCell.self, forCellReuseIdentifier: cellIds[3])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIds[4])
        tableView.tableFooterView = UIView()
        
    }
    
    // MARK: Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }
    
    // MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let set = sets[indexPath.row]
        
        switch exercice?.category {
        case "Poids libres / Machines":
//            cell.textLabel?.text = "\(set.repetitions) REPS || \(set.weight) KGS".set
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[0], for: indexPath) as! RepsWeightCell
            cell.set = set
            return cell
        case "Cardio":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[1], for: indexPath) as! CardioCell
            print(set.duration)
//            cell.textLabel?.text = "\(set.duration / 60 % 60) MIN || \(set.speed) KM / H"
            cell.set = set
            return cell
        case "Poids du corps":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[2], for: indexPath) as! BodyweightCell
            cell.set = set
            return cell
        case "Gainage":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[3], for: indexPath) as! GainageCell
            cell.set = set
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[4], for: indexPath)
            cell.textLabel?.text = ""
            return cell
        }
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
