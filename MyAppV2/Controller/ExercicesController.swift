//
//  ExercicesController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

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
        
        setupUI()
      
        fetchExercices()
    }
    
    private func setupUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "checked_64").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleDone))
        
        [tableView, plusButton].forEach { view.addSubview($0) }
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupTableView()
        
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }
        
        plusButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: tabBarHeight + 16, paddingRight: 16, width: 50, height: 50)
        
    }
    
    @objc private func handleDone() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        training?.isDone = true
        training?.endDate = Date()
        
        do {
            try context.save()
            if let training = training {
                self.delegate?.didFinishTraining(training: training)
                navigationController?.popViewController(animated: true)
            }
        } catch let saveErr {
            print("Failed to save training validation:", saveErr)
        }
        
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


