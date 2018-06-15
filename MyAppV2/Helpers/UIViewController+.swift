//
//  UIViewController+Helpers.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import UserNotifications

extension UIViewController {
    
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupSaveButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sauvegarder", style: .plain, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func showEmptyTextFieldAlert(message: String) {
        let alertController = UIAlertController(title: "Champ vide", message: message, preferredStyle: .alert)
        let alertConfirmedAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertConfirmedAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func sendUserNotification(identifier: String, timeInterval: TimeInterval, title: String, body: String) {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if let err = err {
                print(err)
            }
        }        
    }
    
    func createLabel(for text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
    
    func setupStackview(with views: [UIView], for axis: UILayoutConstraintAxis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = .fillEqually
        stackView.axis = axis
        return stackView
    }
    
    func setupBlackBoldAttributedText(for label: UILabel, firstString: String, secondString: String, size: CGFloat) {
        
        let attributedText = NSMutableAttributedString(string: firstString, attributes: [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: size)])
        
        attributedText.append(NSAttributedString(string: secondString, attributes: [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: size)]))
        
        label.attributedText = attributedText
    }
    
}
