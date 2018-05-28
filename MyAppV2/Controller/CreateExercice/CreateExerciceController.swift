//
//  CreateExerciceController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class CreateExerciceController: UIViewController {
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 0.5
        return visualEffectView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "down-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom de l'exercice"
        label.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray
        textField.textAlignment = .center
        textField.placeholder = "Entrez nom"
        textField.delegate = self
        return textField
    }()
    
    private let primaryGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "Groupe musculaire principal"
        label.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        label.textAlignment = .center
        return label
    }()
    
    private let primaryGroupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sélectionner groupe", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleGroupSelection), for: .touchUpInside)
        return button
    }()
    
    private let secondaryGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "Groupe musculaire secondaire"
        label.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        label.textAlignment = .center
        return label
    }()
    
    private let secondaryGroupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("(Optionnel)", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleGroupSelection), for: .touchUpInside)
        return button
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Catégorie de l'exercice"
        label.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        label.textAlignment = .center
        return label
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exemple: Poids du corps", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(handleGroupSelection), for: .touchUpInside)
        return button
    }()
    
    let groups = ["Pectoraux" ,"Abdos", "Epaules"].sorted()
    let categories = ["Poids libres / Machines", "Cardio","Poids du corps","Gainage"]
    
    @objc fileprivate func handleGroupSelection(button: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        var dataArray: [String] = groups
        
        if button.tag == 2 && dataArray == groups {
            dataArray = categories
        }
        
        dataArray.forEach {
            alertController.addAction(UIAlertAction(title: $0, style: .default, handler: { (action) in
                button.setTitle(action.title, for: .normal)
            })) }
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let tabBarController = tabBarController {
            tabBarController.tabBar.isHidden = true
        }
        
        
        setupViewsAndLayout()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc fileprivate func handleGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        view.frame.origin.y = translation.y
        
        if gesture.state == .ended {
            
            let velocity = gesture.velocity(in: self.view)
            
            if velocity.y > 1000 || view.frame.origin.y >= view.frame.height / 2 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = 0
                }
            }
        }
    }
    
    fileprivate func setupViewsAndLayout() {
        
        [visualEffectView, dismissButton, mainView].forEach { view.addSubview($0) }
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        dismissButton.anchor(top: nil, left: nil, bottom: mainView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 0, width: 25, height: 25)
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mainView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: view.frame.height * 0.7)
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let fieldsStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, primaryGroupLabel, primaryGroupButton, secondaryGroupLabel, secondaryGroupButton, categoryLabel, categoryButton])
        fieldsStackView.distribution = .fillEqually
        fieldsStackView.axis = .vertical
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Annuler", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        let validateButton = UIButton(type: .system)
        validateButton.setTitle("Ajouter", for: .normal)
        validateButton.setTitleColor(.blue, for: .normal)
        validateButton.addTarget(self, action: #selector(handleValidate), for: .touchUpInside)
        
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, validateButton])
        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal
        
        [fieldsStackView, buttonStackView].forEach { mainView.addSubview($0) }
        
        fieldsStackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: nil, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 400)
        
        buttonStackView.anchor(top: nil, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleValidate() {
        
        guard let exerciceName = nameTextField.text else { return }
        guard let primaryGroupName = primaryGroupButton.titleLabel?.text else { return }
        guard let secondaryGroupName = secondaryGroupButton.titleLabel?.text else { return }
        guard let categoryName = categoryButton.titleLabel?.text else { return }
        
        if exerciceName.isEmpty || !groups.contains(primaryGroupName) || !categories.contains(categoryName) {
            let alertController = UIAlertController(title: "Champ vide", message: "Veuillez compléter les champs", preferredStyle: .alert)
            let alertConfirmedAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertConfirmedAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let tuple = CoreDataManager.shared.createExercice(name: exerciceName, category: categoryName, primaryGroup: primaryGroupName, secondaryGroup: secondaryGroupName, training: nil)
        
        if tuple.1 == nil {
            dismiss(animated: true, completion: nil)
        }
    }
}
