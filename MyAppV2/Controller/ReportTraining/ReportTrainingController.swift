//
//  ReportTrainingController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 31/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class ReportTrainingController: UIViewController {
    
    let reportTrainingCellId = "reportTrainingCellId"
    let cellIds = ["repsWeightCellId", "cardioCellId", "bodyweightCellId", "gainageCellId", "cellId"]
    
    var training: Training? {
        didSet {
            print("hello")
            
            guard let startDate = training?.startDate else { return }
            guard let endDate = training?.endDate else { return }
            //                    guard let name = training?.name else { return }
            
            //                    nameLabel.text = name
            
            let calendar = Calendar.current
            var durationText = ""
            let components = calendar.dateComponents([.hour, .minute], from: startDate, to: endDate)
            if let hours = components.hour, let minutes = components.minute {
                if hours < 0 || minutes < 0 || hours > 23 {
                    durationText = ""
                } else {
                    durationText = "\(hours)h" + String(format: "%02d", minutes)
                }
                let attributedText = NSMutableAttributedString(string: "DURÉE\n", attributes: [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: durationText, attributes: [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)]))
                
                durationLabel.attributedText = attributedText
            }
            
            if let numberOfExercices = training?.exercices?.allObjects.count {
                let attributedText = NSMutableAttributedString(string: "EXERCICES\n", attributes: [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: "\(numberOfExercices)", attributes: [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)]))
                
                exercicesNumberLabel.attributedText = attributedText
            }
        }
        
    }
    
    
    var exercices = [Exercice]()
    var sets = [[Set]]()
    
    let tableViewCellHeight: CGFloat = 40
    let tableViewHeaderHeight: CGFloat = 40
    var tableViewHeight: CGFloat = 0
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let scrollContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "down-arrow-black").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let exercicesNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var performancesTableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupSubViews()
        fetchExercices()
        setupHeightsForComponents()
        setupLayout()
        setupTableView()
        
    }
    
    func setupSubViews() {
        
        view.addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(scrollView)
        scrollView.addSubview(scrollContainerView)
        [dismissButton, durationLabel,exercicesNumberLabel,performancesTableView].forEach { scrollContainerView.addSubview($0) }
    }
    
    func setupHeightsForComponents() {
        var numberOfSets = 0
        sets.forEach { numberOfSets += $0.count }
        print(exercices.count, numberOfSets)
        tableViewHeight = CGFloat(exercices.count) * tableViewHeaderHeight + CGFloat(numberOfSets) * tableViewCellHeight
        print(tableViewHeight)
    }
    
    func setupLayout() {
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollContainerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 1300)
        
        dismissButton.anchor(top: scrollContainerView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let durationExercicesStackView = UIStackView(arrangedSubviews: [durationLabel, exercicesNumberLabel])
        durationExercicesStackView.axis = .horizontal
        durationExercicesStackView.distribution = .fillEqually
        
        scrollContainerView.addSubview(durationExercicesStackView)
        
        durationExercicesStackView.anchor(top: dismissButton.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        performancesTableView.anchor(top: durationExercicesStackView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: tableViewHeight)
    }
    
    private func fetchExercices() {
        guard let trainingExercices = training?.exercices?.allObjects as? [Exercice] else { return }
        exercices = trainingExercices.sorted(by: { $0.date! < $1.date!  })
        exercices.forEach { fetchSets(exercice: $0)  }
    }
    
    private func fetchSets(exercice: Exercice) {
        guard let exerciceSets = exercice.sets?.allObjects as? [Set] else { return }
        sets.append( exerciceSets.sorted(by: { $0.date! < $1.date!} ))
    }
    
}

















