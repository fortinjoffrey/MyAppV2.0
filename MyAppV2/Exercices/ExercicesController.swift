//
//  ExercicesController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class ExercicesController: UITableViewController {
    
    var training: Training? {
        didSet {
            
        }
    }
    
    var exercices = [Exercice]()
    
    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        navigationItem.title = training?.name
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        
        setupTableView()
        
        fetchExercices()
    }
    
    @objc private func handleAdd() {
        
        let createExerciceController = CreateExerciceController()
        let navController = UINavigationController(rootViewController: createExerciceController)
        createExerciceController.training = training
        createExerciceController.delegate = self
        present(navController, animated: true, completion: nil)        
    }
    
    private func fetchExercices() {
        
        guard let trainingExercices = training?.exercices?.allObjects as? [Exercice] else { return }
        
        let sortedExercices = trainingExercices.sorted(by: { $0.date! < $1.date! })
        
        self.exercices = sortedExercices        
    }
    
}
