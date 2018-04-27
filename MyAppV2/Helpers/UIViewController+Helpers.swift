//
//  UIViewController+Helpers.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupSaveButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func showEmptyTrainingNameAlert() {
        let alertController = UIAlertController(title: "Champ vide", message: "Entrez un nom pour votre séance", preferredStyle: .alert)
        let alertConfirmedAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertConfirmedAction)
        present(alertController, animated: true, completion: nil)
    }
}
