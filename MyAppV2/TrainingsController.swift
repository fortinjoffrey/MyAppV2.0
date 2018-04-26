//
//  TableViewController.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 25/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

class TrainingsController: UITableViewController, CreateTrainingControllerDelegate {
    func didAddTraining(training: Training) {
        trainings.append(training)
        let newIndexPath = IndexPath(row: trainings.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    var trainings = [Training]()
//    ]
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkBlue
        
        navigationItem.title = "Trainings"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddTraining))
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none
        tableView.separatorColor = .red
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        
        fetchTrainings()
        
    }
    
    private func fetchTrainings() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Training>(entityName: "Training")
        
        do {
            let trainings = try context.fetch(fetchRequest)
            
            self.trainings = trainings
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch trainings:", fetchErr)
        }
        
    }
    
    @objc private func handleAddTraining() {
        print("Trying to add a training")
        
        let createTrainingController = CreateTrainingController()
        let navController = UINavigationController(rootViewController: createTrainingController)

        createTrainingController.delegate = self
        
        present(navController, animated: true, completion: nil)        
    }
    
    
}

extension TrainingsController {
    
    
    // MARK: Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainings.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
        
        cell.training = trainings[indexPath.row]
        
        return cell
    }
    
    
    
    // MARK: Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Supprimer") { (action, view, success) in
            
            
            self.trainings.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            success(true)
        }
        deleteAction.backgroundColor = .red
        
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
    
    // MARK: Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    /*
     
     */
    
    
    
}

