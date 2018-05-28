//
//  CreateExerciceController+UITextFieldDelegate.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 30/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension CreateExerciceController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField != categoryTextfield {
            return true
        } else {
            view.endEditing(true)
            handleCategoryTextfield()
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
    
}
