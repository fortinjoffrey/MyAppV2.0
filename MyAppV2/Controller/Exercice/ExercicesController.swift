//
//  ExercicesController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol ExercicesControllerDelegate {
    func didFinishTraining(training: Training)
}

class ExercicesController: UIViewController {
    
    var delegate: ExercicesControllerDelegate?
    var exercices = [Exercice]()
    let cellId = "cellId"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var training: Training? {
        didSet {
            navigationItem.title = training?.name
            setupNavBar()
        }
    }
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_green").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        fetchExercices()
    }
    
    fileprivate func setupNavBar() {
        if let isDone = training?.isDone {
            if !isDone {
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "checked_64").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleDone))
            }
        }
    }
    
    @objc private func handleDone() {
        if CoreDataManager.shared.saveTrainingIsDone(isDone: true, training: training) {
            if let training = training {
                self.delegate?.didFinishTraining(training: training)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func handleAdd() {
        let listExercicesAutoUpdateController = ListExercicesAutoUpdateController()
        listExercicesAutoUpdateController.training = training
        listExercicesAutoUpdateController.delegate = self
        let navController = UINavigationController(rootViewController: listExercicesAutoUpdateController)
        present(navController, animated: true, completion: nil)        
    }
    
    private func fetchExercices() {
        guard let trainingExercices = training?.exercices?.allObjects as? [Exercice] else { return }
        let sortedExercices = trainingExercices.sorted(by: { $0.date! < $1.date! })
        self.exercices = sortedExercices        
    }
    
}


