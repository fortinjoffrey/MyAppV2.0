//
//  TrainingsController.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 25/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

class TrainingsController: UITableViewController {
    
    var trainings = [Training]()

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkBlue
        
        navigationItem.title = "Trainings"
        
        setupPlusButtonInNavBar(selector: #selector(handleAddTraining))
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none
        tableView.separatorColor = .red
        
        tableView.register(TrainingCell.self, forCellReuseIdentifier: cellId)
        
        
        self.trainings = CoreDataManager.shared.fetchTrainings()
        
    }
    
    
    @objc private func handleAddTraining() {        
        
        let createTrainingController = CreateTrainingController()
        let navController = UINavigationController(rootViewController: createTrainingController)

        createTrainingController.delegate = self
        
        present(navController, animated: true, completion: nil)        
    }
    
    
}



