//
//  ListExercicesAutoUpdateController+Exercices.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 29/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ListExercicesAutoUpdateController {
    
    func createDefaultsExercices() {
        
        let defaultsExercices = [
            // PECTORAUX DE BASE
            ["Developpe couche barre", "Pectoraux", "Triceps", "Poids libre"],
            ["Developpe couche haltères","Pectoraux","Triceps","Poids libre"],
            ["Developpe incline barre","Pectoraux","Triceps",""],
            ["Developpe incline haltères","Pectoraux","Triceps",""],
            ["Developpe decline barre","Pectoraux","Triceps",""],
            ["Dips prise large buste penche","Pectoraux","Triceps","Poids du corps"],
            ["Pull over","Pectoraux","Triceps",""],
            ["Pec deck","Pectoraux","Triceps",""],
            ["Pompes prise large","Pectoraux","Triceps",""],            
            ["ecarte a la machine","Pectoraux","Triceps",""],
            ["ecarte couche haltères","Pectoraux","Triceps",""],
            ["ecarte couche poulie","Pectoraux","Triceps",""],
            ["ecarte decline haltères","Pectoraux","Triceps",""],
            ["ecarte decline poulie","Pectoraux","Triceps",""],
            ["ecarte incline haltères","Pectoraux","Triceps",""],
            ["ecarte incline poulie","Pectoraux","Triceps",""],
            
            // DELTOIDES DE BASE
            ["Developpe militaire barre","Deltoïdes","",""],
            ["Developpe militaire haltères","Deltoïdes","",""],
            ["Developpe militaire machines","Deltoïdes","",""],
            ["Developpe nuque barre","Deltoïdes","",""],
            ["Developpe nuque haltères","Deltoïdes","",""],
            ["Developpe arnold","Deltoïdes","",""],
            ["elevations laterales haltères","Deltoïdes","",""],
            ["elevations laterales poulie","Deltoïdes","",""],
            ["elevations frontales haltères","Deltoïdes","",""],
            ["elevations frontales barre","Deltoïdes","",""],
            ["elevations frontales poulie","Deltoïdes","",""],
            ["Rowing barre coudes ouverts","Deltoïdes","",""],
            ["Rowing poulie coudes ouverts","Deltoïdes","",""],
            ["Oiseau poulie","Deltoïdes","Trapèzes",""],
            ["Oiseau haltères","Deltoïdes","Trapèzes",""],
            
            // ABDOMINAUX
            ["Crunch","Abdominaux","",""],
            ["Crunch poulie haute","Abdominaux","",""],
            ["Crunch a la machine","Abdominaux","",""],
            ["Enroulement du bassin","Abdominaux","",""],
            ["Gainage planche","Abdominaux","","Gainage"],
            ["Gainage oblique","Abdominaux","","Gainage"],
            ["Flexions laterales","Abdominaux","",""],
            ["Obliques","Abdominaux","",""],
            
            // QUADRICEPS
            ["Hack squat","Quadriceps","",""],
            ["Front squat barre","Quadriceps","",""],
            ["Front squat smith machine","Quadriceps","",""],
            ["Squat barre","Quadriceps","",""],
            ["Squat smith machine","Quadriceps","",""],
            ["Montee sur banc","Quadriceps","",""],
            ["Fente a la smith machine","Quadriceps","",""],
            ["Fente avec haltères","Quadriceps","",""],
            ["Leg extension","Quadriceps","",""],
            
            // BICEPS
            ["Curl avec haltères","Biceps","",""],
            ["Curl a la barre","Biceps","",""],
            ["Curl a la poulie basse","Biceps","",""],
            ["Curl incline","Biceps","",""],
            ["Curl marteau a la poulie basse","Biceps","",""],
            ["Curl marteau avec haltères","Biceps","",""],
            ["Curl pupitre a la poulie basse","Biceps","",""],
            ["Curl pupitre avec haltères","Biceps","",""],
            ["Curl pupitre a la barre","Biceps","",""],
            ["Curl araignee avec haltères","Biceps","",""],
            ["Curl araignee a la barre","Biceps","",""],
            ["Curl concentre","Biceps","",""],
            ["Curl a la poulie vis a vis","Biceps","",""],
            
            // AVANT BRAS
            ["Curl inverse a la poulie","Avant-bras","",""],
            ["Curl inverse avec haltères","Avant-bras","",""],
            ["Curl inverse au pupitre","Avant-bras","",""],
            ["Extension des poignets","Avant-bras","",""],
            ["Flexion des poignets","Avant-bras","",""],
            
            // TRAPEZES
            
            ["Shrug avec haltères","Trapèzes","",""],
            ["Shrug a la barre","Trapèzes","",""],
            ["Shrug a la machine","Trapèzes","",""],
            ["Shrug a la poulie","Trapèzes","",""],
            
            // TRICEPS
            ["Barre au front a la poulie","Triceps","",""],
            ["Barre au front a la barre","Triceps","",""],
            ["Developpe couche prise serree","Triceps","",""],
            ["Dips a la machine","Triceps","",""],
            ["Dips entre deux bancs","Triceps","",""],
            ["Dips prise serree","Triceps","",""],
            ["Extension a la poulie haute corde","Triceps","",""],
            ["Extension a la poulie haute barre droite","Triceps","",""],
            ["Extension nuque avec haltères","Triceps","",""],
            ["Extension nuque a la poulie","Triceps","",""],
            ["Kickback","Triceps","",""],
            ["Kickback a la poulie","Triceps","",""],
            ["Pompes prise diamant","Triceps","",""],
            ["Pompes prise serree","Triceps","",""],
            
            // LOMBAIRES
            ["Good morning","Lombaires","",""],
            ["Extension au banc a lombaires","Lombaires","",""],
            ["Souleve de terre a la poulie","Lombaires","",""],
            
            // ISCHIO
            ["Leg curl","Ischio-Jambiers","",""],
            
            // DORSAUX
            ["Traction prise large","Dorsaux","",""],
            ["Traction prise neutre","Dorsaux","",""],
            ["Traction prise serree en pronation","Dorsaux","",""],
            ["Traction prise serree en supination","Dorsaux","",""],
            ["Traction a la machine","Dorsaux","",""],
            ["Traction a la poulie haute en pronation","Dorsaux","",""],
            ["Traction a la poulie haute en supination","Dorsaux","",""],
            ["Rowing assis a la poulie basse","Dorsaux","",""],
            ["Rowing a la barre","Dorsaux","",""],
            ["Rowing avec haltères","Dorsaux","",""],
            
            
            // FESSIERS
            ["Souleve de terre","Fessiers","",""],
            ["Souleve de terre sumo","Fessiers","",""],
            ["Fente glissee","Fessiers","",""],
            ["Fente a la smith machine","Fessiers","",""],
            
            // MOLLETS
            ["Chameau","Mollets","",""],
            ["Mollets assis","Mollets","",""],
            ["Mollets debout a la machine","Mollets","",""],
            ["Mollets debout","Mollets","",""],
            ["","Mollets","",""],
            ]
        
        defaultsExercices.forEach { (exercice) in
            _ = CoreDataManager.shared.createExercice(name: exercice[0], category: exercice[3], primaryGroup: exercice[1], secondaryGroup: exercice[2], training: nil)
        }
    }
    
}
