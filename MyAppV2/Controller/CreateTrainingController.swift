//
//  CreateTrainingController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateTrainingControllerDelegate {
    func didAddTraining(training: Training)
    func didEditTraining(training: Training)
}

class CreateTrainingController: UIViewController {
    
    var training: Training? {
        didSet {
            guard let name = training?.name else { return }
            guard let startDate = training?.startDate else { return }
            
            nameTextField.text = name
            startDatePicker.date = startDate
            isDone = training?.isDone
            
            if let endDate = training?.endDate, let notation = training?.notation, let tirednessNotation = training?.tirednessNotation, let notes = training?.notes {
                
                endDatePicker.date = endDate
                notationPicker.selectRow(Int(notation), inComponent: 0, animated: false)
                tirednessNotationPicker.selectRow(Int(tirednessNotation), inComponent: 0, animated: false)
                notesTextView.text = notes
            }
        }
    }
    
    var isDone: Bool?
    
    var selectedTextArea: Any?
    var textfieldMode: Bool?
    let heightForHorizontalPickerView: CGFloat = 50
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom de la séance"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Ex: Jambes / Épaules"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Entrez l'heure de début"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.locale = Locale(identifier: "FR_fr")
        return dp
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Fin de l'entraînement"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let endDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.locale = Locale(identifier: "FR_fr")
        return dp
    }()
    
    private let notationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notez la séance"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let notationPicker: NotationPickerView = {
        let pv = NotationPickerView()
        pv.dataSource = pv
        pv.delegate = pv
        pv.selectRow(5, inComponent: 0, animated: false)
        let rotationAngle: CGFloat = -.pi / 2
        pv.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return pv
    }()
    
    private let tirednessNotationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notez votre état de fatigue"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let tirednessNotationPicker: NotationPickerView = {
        let pv = NotationPickerView()
        pv.dataSource = pv
        pv.delegate = pv
        pv.selectRow(5, inComponent: 0, animated: false)
        let rotationAngle: CGFloat = -.pi / 2
        pv.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return pv
    }()
    
    private let notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Remarques sur la séance"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var notesTextView: UITextView = {
        let tf = UITextView()
        tf.delegate = self
        tf.text = ""
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.backgroundColor = .white
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        navigationItem.title = training == nil ? "Créer training" : "Modifier"
        
        setupCancelButton()
        
        setupSaveButtonInNavBar(selector: #selector(handleSave))
        
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupObservers()
    }
    
    fileprivate func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleSave() {
        
        guard let name = nameTextField.text else { return }
        guard let isDone = isDone else { return }
        
        if name.isEmpty {
            showEmptyTextFieldAlert(message: "Entrer un nom pour votre séance")
            return
        }
        
        training == nil ? createTraining(name: name, isDone: isDone) : saveTrainingChanges(name: name, isDone: isDone)
        
    }
    
    private func createTraining(name: String, isDone: Bool) {
        
        let endDate = isDone ? endDatePicker.date : startDatePicker.date
        
        let tuple = CoreDataManager.shared.createTraining(name: name, startDate: startDatePicker.date, endDate: endDate, notation: notationPicker.selectedData, tirednessNotation: tirednessNotationPicker.selectedData, notes: notesTextView.text, isDone: isDone)
        
        print(endDatePicker.date)
        
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func saveTrainingChanges(name: String, isDone: Bool) {
        
        let tuple = CoreDataManager.shared.saveTrainingChanges(name: name, startDate: startDatePicker.date, endDate: endDatePicker.date, notation: notationPicker.selectedData, tirednessNotation: tirednessNotationPicker.selectedData, notes: notesTextView.text, isDone: isDone, training: training)
        
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        
        switch isDone {
        case true:
            setupUIForDoneTraining()
        default:
            _ = setupMinimalUI()
        }
    }
    
    func setupUIForDoneTraining() {
        
        let scrollContainerView = setupMinimalUI()
        
        let notationContainerView = UIView()
        let tirednessNotationContainerView = UIView()
        
        [endDateLabel, endDatePicker, notationLabel, notationContainerView, tirednessNotationLabel, tirednessNotationContainerView, notesLabel, notesTextView].forEach { scrollContainerView.addSubview($0)}
        
        endDateLabel.anchor(top: startDatePicker.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        endDatePicker.anchor(top: endDateLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 65)
        
        notationLabel.anchor(top: endDatePicker.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        notationContainerView.anchor(top: notationLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 65)
        
        notationContainerView.addSubview(notationPicker)
        
        notationPicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightForHorizontalPickerView, height: view.frame.width)
        notationPicker.centerXAnchor.constraint(equalTo: notationContainerView.centerXAnchor).isActive = true
        notationPicker.centerYAnchor.constraint(equalTo: notationContainerView.centerYAnchor).isActive = true
        
        tirednessNotationLabel.anchor(top: notationContainerView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        tirednessNotationContainerView.anchor(top: tirednessNotationLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 65)
        tirednessNotationContainerView.addSubview(tirednessNotationPicker)
        
        tirednessNotationPicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightForHorizontalPickerView, height: view.frame.width)
        tirednessNotationPicker.centerXAnchor.constraint(equalTo: tirednessNotationContainerView.centerXAnchor).isActive = true
        tirednessNotationPicker.centerYAnchor.constraint(equalTo: tirednessNotationContainerView.centerYAnchor).isActive = true
        
        notesLabel.anchor(top: tirednessNotationContainerView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        notesTextView.anchor(top: notesLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    func setupMinimalUI() -> UIView {
        
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let scrollContainerView = UIView()
        scrollContainerView.backgroundColor = .lightBlue
        
        scrollView.addSubview(scrollContainerView)
        
        scrollContainerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 800)
        
        
        [nameLabel,nameTextField, startDateLabel, startDatePicker].forEach { scrollContainerView.addSubview($0)}
        
        nameLabel.anchor(top: scrollContainerView.topAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        nameTextField.anchor(top: nameLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
        
        startDateLabel.anchor(top: nameTextField.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        startDatePicker.anchor(top: startDateLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 65)
        
        return scrollContainerView
    }
}
