//
//  SettingsController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 17/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    let subtitleCellId = "subtitleCellId"
    let rightDetailCellId = "rightDetailCellId"
    let defaultCellId = "defaultCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Paramètres"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
        tableView.register(SettingsSubtitleCell.self, forCellReuseIdentifier: subtitleCellId)
        tableView.register(SettingsRightDetailCell.self, forCellReuseIdentifier: rightDetailCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: subtitleCellId, for: indexPath)
            cell.textLabel?.text = "Title"
            cell.detailTextLabel?.text = "Subtitle"            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: rightDetailCellId, for: indexPath)
            cell.textLabel?.text = "Timer par défaut"
            cell.detailTextLabel?.text = "1:30"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellId, for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = "Lancer timer automatiquement"
            let automaticTimerSwitch = UISwitch()
            
            if let state = UserDefaults.standard.value(forKey: "automaticTimerSwitchIsOn") as? Bool {
                automaticTimerSwitch.isOn = state
            } else {
                automaticTimerSwitch.isOn = true
            }                        
            automaticTimerSwitch.tag = 0
            automaticTimerSwitch.addTarget(self, action: #selector(handleSwitchValueChanged), for: .valueChanged)
            cell.accessoryView = automaticTimerSwitch
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: rightDetailCellId, for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = "Version"
            cell.detailTextLabel?.text = "1.0"
            cell.accessoryType = .none
            return cell
        }
    }
    
    @objc fileprivate func handleSwitchValueChanged( sender: UISwitch) {
        if sender.tag == 0 {
            UserDefaults.standard.set(sender.isOn, forKey: "automaticTimerSwitchIsOn")
        }
    }
    
    
}
