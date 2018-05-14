//
//  SetsController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol SetsControllerDelegate {
    func didFinishExercice(exercice: Exercice)
}

class SetsController: UIViewController {
    
    var delegate: SetsControllerDelegate?
    
    var trainingIsDone: Bool? = false
    
    var exercice: Exercice? {
        didSet {
            navigationItem.title = exercice?.name
        }
    }
    
    var sets = [Set]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_green").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleDone() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        exercice?.isDone = true
        
        do {
            try context.save()
            if let exercice = exercice {
                self.delegate?.didFinishExercice(exercice: exercice)
                navigationController?.popViewController(animated: true)
            }           
        } catch let saveErr {
            print("Failed to save exercice validation:", saveErr)
        }
    }
  
    let cellIds = ["repsWeightCellId", "cardioCellId", "bodyweightCellId", "gainageCellId", "cellId"]    

    @objc private func handleAdd() {
     
        let createSetController = CreateSetController()
        createSetController.exercice = exercice        
        createSetController.delegate = self
        
        let navController = UINavigationController(rootViewController: createSetController)
        
        present(navController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        setupUI()
        setupTableView()
        fetchSets()
        
    }
    
    func setupUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "checked_64").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleDone))
        
        [tableView, plusButton].forEach { view.addSubview($0) }
        
        tableView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
        
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }
        
        plusButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: tabBarHeight + 16, paddingRight: 16, width: 50, height: 50)
    
        
    }
    
    func fetchSets() {
        
        guard let exerciceSets = exercice?.sets?.allObjects as? [Set] else { return }
        
        let sortedSets = exerciceSets.sorted(by: { $0.date! < $1.date! })
        
        sets = sortedSets
    }
}








