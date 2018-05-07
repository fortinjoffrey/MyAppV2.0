//
//  CreateSetController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateSetControllerDelegate {
    func didAddSet(set: Set)
    func didEditSet(set: Set)
    
}

class CreateSetController: UIViewController {
    
    var delegate: CreateSetControllerDelegate?
    
    var exercice: Exercice? {
        didSet {
            navigationItem.title = exercice?.name
        }
    }

    // MARK: Labels
    let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "reps".uppercased()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "KGS"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let durationLabel: UILabel = {
        let label = UILabel()
        label.text = "minutes".uppercased()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let speedLabel: UILabel = {
        let label = UILabel()
        label.text = "km / h".uppercased()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let gainageMinutesLabel: UILabel = {
        let label = UILabel()
        label.text = "minutes".uppercased()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let gainageSecondsLabel: UILabel = {
        let label = UILabel()
        label.text = "secondes".uppercased()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    // MARK: Value Labels
    let repsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let weightValueLabel: UILabel = {
        let label = UILabel()
        label.text = "24"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let durationValueLabel: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let speedValueLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let gainageMinutesValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    let gainageSecondsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    // MARK: Picker Data Variables
    var repsPickerData = [Int16]()
    var weightPickerData = [Int16]()
    var durationPickerData = [Int16]()
    var speedPickerData = [Int16]()
    var gainageMinutesPickerData = [Int16]()
    var gainageSecondsPickerData = [Int16]()
    
    // MARK: Picker Views
    lazy var repsPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var weightPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var durationPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var speedPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var gainageMinutesPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    lazy var gainageSecondsPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    
    // MARK: Validate Button
    let validateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Valider", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleValidate), for: .touchUpInside)
        return button
    }()
    
    @objc func handleValidate() {
        
        guard let exercice = exercice else { return }
        
        var tuple: (Set?, Error?)
        
        switch exercice.category {
        case "Poids libres / Machines":
            
            let repetitions = repsPickerData[repsPickerView.selectedRow(inComponent: 0)]
            let weight = weightPickerData[weightPickerView.selectedRow(inComponent: 0)]
            
            tuple = CoreDataManager.shared.createSet(duration: 0, speed: 0, repetitions: repetitions, weight: weight, exercice: exercice)
            
        case "Cardio":
            
            let durationMinutes = durationPickerData[durationPickerView.selectedRow(inComponent: 0)]
            let speed = speedPickerData[speedPickerView.selectedRow(inComponent: 0)]
            
            tuple = CoreDataManager.shared.createSet(duration: durationMinutes * 60, speed: speed, repetitions: 0, weight: 0, exercice: exercice)
            
        case "Poids du corps":
            
            let repetitions = repsPickerData[repsPickerView.selectedRow(inComponent: 0)]
            
            tuple = CoreDataManager.shared.createSet(duration: 0, speed: 0, repetitions: repetitions, weight: 0, exercice: exercice)
            
        case "Gainage":
            
            let durationMinutes = gainageMinutesPickerData[gainageMinutesPickerView.selectedRow(inComponent: 0)]
            let durationSeconds = gainageSecondsPickerData[gainageSecondsPickerView.selectedRow(inComponent: 0)]
            
            let duration = durationMinutes * 60 + durationSeconds
            
            tuple = CoreDataManager.shared.createSet(duration: duration, speed: 0, repetitions: 0, weight: 0, exercice: exercice)
            
        default:
            return
        }
        
        // if it is not en cours then
//        dismiss(animated: true) {
//            if let set = tuple.0 {
//                self.delegate?.didAddSet(set: set)
//            }
//        }
        
        
        // else if it's en cours et do not dismiss the creation
        if let set = tuple.0 {
            self.delegate?.didAddSet(set: set)
        }
        
        let runningTimerController = RunningTimerController()
        runningTimerController.timerValue = CGFloat(90)
        present(runningTimerController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelButton()
        setupUI()
        
    }
    
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        switch exercice?.category {
        case "Poids libres / Machines":
            setupUIForRepsWeight()
        case "Cardio":
            setupUIForCardio()
        case "Poids du corps":
            setupUIForBodyweight()
        case "Gainage":
            setupUIForGainage()
        default:
            return
        }
    }
    
    func setupUIForRepsWeight() {
        
        setupRepsWeightPickerViews()
        
        let repsStackView = UIStackView(arrangedSubviews: [repsLabel, repsValueLabel])
        repsStackView.axis = .vertical
        repsStackView.distribution = .fillEqually
        
        let weightStackView = UIStackView(arrangedSubviews: [weightLabel, weightValueLabel])
        weightStackView.axis = .vertical
        weightStackView.distribution = .fillEqually
        
        let repsWeightLabelStackView = UIStackView(arrangedSubviews: [repsStackView, weightStackView])
        repsWeightLabelStackView.axis = .horizontal
        repsWeightLabelStackView.distribution = .fillEqually
        
        let repsWeightPickerStackView = UIStackView(arrangedSubviews: [repsPickerView, weightPickerView])
        repsWeightPickerStackView.axis = .horizontal
        repsWeightPickerStackView.distribution = .fillEqually
        
        [repsWeightLabelStackView, repsWeightPickerStackView, validateButton].forEach { view.addSubview($0) }
        
        repsWeightLabelStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        repsWeightPickerStackView.anchor(top: nil, left: view.leftAnchor, bottom: validateButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
        
        validateButton.anchor(top: repsWeightPickerStackView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 32, paddingRight: 16, width: 0, height: 0)
    }
    
    func setupUIForCardio() {
        
        setupDurationSpeedPickerViews()
        
        let durationStackView = UIStackView(arrangedSubviews: [durationLabel, durationValueLabel])
        durationStackView.axis = .vertical
        durationStackView.distribution = .fillEqually
        
        let speedStackView = UIStackView(arrangedSubviews: [speedLabel, speedValueLabel])
        speedStackView.axis = .vertical
        speedStackView.distribution = .fillEqually
        
        let durationSpeedLabelStackView = UIStackView(arrangedSubviews: [durationStackView, speedStackView])
        durationSpeedLabelStackView.axis = .horizontal
        durationSpeedLabelStackView.distribution = .fillEqually
        
        let durationSpeedPickerStackView = UIStackView(arrangedSubviews: [durationPickerView, speedPickerView])
        durationSpeedPickerStackView.axis = .horizontal
        durationSpeedPickerStackView.distribution = .fillEqually
        
        [durationSpeedLabelStackView, durationSpeedPickerStackView, validateButton].forEach { view.addSubview($0) }
        
        durationSpeedLabelStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        durationSpeedPickerStackView.anchor(top: nil, left: view.leftAnchor, bottom: validateButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
        
        validateButton.anchor(top: durationSpeedPickerStackView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 32, paddingRight: 16, width: 0, height: 0)
    }
    
    func setupUIForBodyweight() {
        
        setupRepsWeightPickerViews()
        
        let repsStackView = UIStackView(arrangedSubviews: [repsLabel, repsValueLabel])
        repsStackView.axis = .vertical
        repsStackView.distribution = .fillEqually
        
        [repsStackView, repsPickerView, validateButton].forEach { view.addSubview($0) }
        
        repsStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        repsPickerView.anchor(top: nil, left: view.leftAnchor, bottom: validateButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
        
        validateButton.anchor(top: repsPickerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 32, paddingRight: 16, width: 0, height: 0)
    }
    
    func setupUIForGainage() {
        
        setupMinutesSecondsPickerViews()
        
        let minutesStackView = UIStackView(arrangedSubviews: [gainageMinutesLabel, gainageMinutesValueLabel])
        minutesStackView.axis = .vertical
        minutesStackView.distribution = .fillEqually
        
        let secondsStackView = UIStackView(arrangedSubviews: [gainageSecondsLabel, gainageSecondsValueLabel])
        secondsStackView.axis = .vertical
        secondsStackView.distribution = .fillEqually
        
        let minutesSecondsLabelStackView = UIStackView(arrangedSubviews: [minutesStackView, secondsStackView])
        minutesSecondsLabelStackView.axis = .horizontal
        minutesSecondsLabelStackView.distribution = .fillEqually
        
        let minutesSecondsPickerStackView = UIStackView(arrangedSubviews: [gainageMinutesPickerView, gainageSecondsPickerView])
        minutesSecondsPickerStackView.axis = .horizontal
        minutesSecondsPickerStackView.distribution = .fillEqually
        
        [minutesSecondsLabelStackView, minutesSecondsPickerStackView, validateButton].forEach { view.addSubview($0) }
        
        minutesSecondsLabelStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        minutesSecondsPickerStackView.anchor(top: nil, left: view.leftAnchor, bottom: validateButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height / 2)
        
        validateButton.anchor(top: minutesSecondsPickerStackView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 32, paddingRight: 16, width: 0, height: 0)
    }
    
    
    
}
