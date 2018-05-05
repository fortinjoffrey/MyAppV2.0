//
//  RepsWeightCell.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 03/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class RepsWeightCell: UITableViewCell {
    
    var set: Set? {
        didSet {
            
            if let reps = set?.repetitions, let weight = set?.weight {
                
                let boldAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor:UIColor.black]
                
                let valueAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor:UIColor.blue,NSAttributedStringKey.backgroundColor:UIColor.orange]
                
                let repsString = String(reps)
                    
//                let finalRepsString = "".padding(toLength: 3 - repsString.count , withPad: " ", startingAt: 0) + "\(reps)"
                
                let finalRepsString = repsString.padding(toLength: 3, withPad: " ", startingAt: 0)
                
                let weightString = String(weight)
                
//                let finalWeightString = "".padding(toLength: 3 - weightString.count, withPad: " ", startingAt: 0) + "\(weight)"
                let finalWeightString = weightString.padding(toLength: 3, withPad: " ", startingAt: 0)
                
                
                let attributedText = NSMutableAttributedString(string: finalRepsString, attributes: valueAttributes)
                
                attributedText.append(NSAttributedString(string: "    REPS\t\t", attributes: boldAttributes ))
                
                attributedText.append(NSAttributedString(string: finalWeightString, attributes: valueAttributes))
                
                attributedText.append(NSAttributedString(string: "    KGS", attributes: boldAttributes))
                
                label.attributedText = attributedText
            }
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        
        let boldAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 24), NSAttributedStringKey.foregroundColor:UIColor.blue]
        
        let valueAttributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor:UIColor.black]
        
        let attributedText = NSMutableAttributedString(string: "12\t", attributes: valueAttributes)
        
        attributedText.append(NSAttributedString(string: "REPS\t\t", attributes: boldAttributes ))
        
        attributedText.append(NSAttributedString(string: "24\t", attributes: valueAttributes))
        
        attributedText.append(NSAttributedString(string: "KGS", attributes: boldAttributes))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        
//        [repsValueLabel, weightValueLabel].forEach { addSubview($0) }
        [label].forEach { addSubview($0) }
        
        label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        
        
    }
        
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
