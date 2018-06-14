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
        
//        let categories = ["Poids libres","Machines, poulie", "Cardio","Poids du corps","Gainage"]
        
        let defaultsExercices = [
            // PECTORAUX DE BASE
            ["Developpe couche barre", "Pectoraux", "Triceps", "Poids libres"],
            ["Developpe couche haltères","Pectoraux","Triceps","Poids libres"],
            ["Developpe incline barre","Pectoraux","Triceps","Poids libres"],
            ["Developpe incline haltères","Pectoraux","Triceps","Poids libres"],
            ["Developpe decline barre","Pectoraux","Triceps","Poids libres"],
            ["Dips prise large buste penche","Pectoraux","Triceps","Poids du corps"],
            ["Pull over","Pectoraux","Triceps","Poids libres"],
            ["Pec deck","Pectoraux","Triceps","Machines, poulie"],
            ["Pompes prise large","Pectoraux","Triceps","Poids du corps"],
            ["Ecarte a la machine","Pectoraux","Triceps","Machines, poulie"],
            ["Ecarte couche haltères","Pectoraux","Triceps","Poids libres"],
            ["Ecarte couche poulie","Pectoraux","Triceps","Machines, poulie"],
            ["Ecarte decline haltères","Pectoraux","Triceps","Poids libres"],
            ["Ecarte decline poulie","Pectoraux","Triceps","Machines, poulie"],
            ["Ecarte incline haltères","Pectoraux","Triceps","Poids libres"],
            ["Ecarte incline poulie","Pectoraux","Triceps","Machines, poulie"],
            
            // DELTOIDES DE BASE
            ["Developpe militaire barre","Deltoïdes","","Poids libres"],
            ["Developpe militaire haltères","Deltoïdes","","Poids libres"],
            ["Developpe militaire machines","Deltoïdes","","Machines, poulie"],
            ["Developpe nuque barre","Deltoïdes","","Poids libres"],
            ["Developpe nuque haltères","Deltoïdes","","Poids libres"],
            ["Developpe arnold","Deltoïdes","","Poids libres"],
            ["elevations laterales haltères","Deltoïdes","","Poids libres"],
            ["elevations laterales poulie","Deltoïdes","","Machines, poulie"],
            ["elevations frontales haltères","Deltoïdes","","Poids libres"],
            ["elevations frontales barre","Deltoïdes","","Poids libres"],
            ["elevations frontales poulie","Deltoïdes","","Machines, poulie"],
            ["Rowing barre coudes ouverts","Deltoïdes","","Poids libres"],
            ["Rowing poulie coudes ouverts","Deltoïdes","","Machines, poulie"],
            ["Oiseau poulie","Deltoïdes","Trapèzes","Machines, poulie"],
            ["Oiseau haltères","Deltoïdes","Trapèzes","Poids libres"],
            
            // ABDOMINAUX
            ["Crunch","Abdominaux","","Poids du corps"],
            ["Crunch poulie haute","Abdominaux","","Machines, poulie"],
            ["Crunch a la machine","Abdominaux","","Machines, poulie"],
            ["Enroulement du bassin","Abdominaux","","Poids du corps"],
            ["Gainage planche","Abdominaux","","Gainage"],
            ["Gainage oblique","Abdominaux","","Gainage"],
            ["Flexions laterales","Abdominaux","","Poids du corps"],
            ["Obliques","Abdominaux","","Poids du corps"],
            
            // QUADRICEPS
            ["Hack squat","Quadriceps","","Poids libres"],
            ["Front squat barre","Quadriceps","","Poids libres"],
            ["Front squat smith machine","Quadriceps","","Machines, poulie"],
            ["Squat barre","Quadriceps","","Poids libres"],
            ["Squat smith machine","Quadriceps","","Machines, poulie"],
            ["Montee sur banc","Quadriceps","","Poids du corps"],
            ["Fente a la smith machine","Quadriceps","","Machines, poulie"],
            ["Fente avec haltères","Quadriceps","","Poids libres"],
            ["Leg extension","Quadriceps","","Machines, poulie"],
            
            // BICEPS
            ["Curl avec haltères","Biceps","","Poids libres"],
            ["Curl a la barre","Biceps","","Poids libres"],
            ["Curl a la poulie basse","Biceps","","Machines, poulie"],
            ["Curl incline","Biceps","","Poids libres"],
            ["Curl marteau a la poulie basse","Biceps","","Machines, poulie"],
            ["Curl marteau avec haltères","Biceps","","Poids libres"],
            ["Curl pupitre a la poulie basse","Biceps","","Machines, poulie"],
            ["Curl pupitre avec haltères","Biceps","","Poids libres"],
            ["Curl pupitre a la barre","Biceps","","Poids libres"],
            ["Curl araignee avec haltères","Biceps","","Poids libres"],
            ["Curl araignee a la barre","Biceps","","Poids libres"],
            ["Curl concentre","Biceps","","Poids libres"],
            ["Curl a la poulie vis a vis","Biceps","","Machines, poulie"],
            
            // AVANT BRAS
            ["Curl inverse a la poulie","Avant-bras","","Machines, poulie"],
            ["Curl inverse avec haltères","Avant-bras","","Poids libres"],
            ["Curl inverse au pupitre","Avant-bras","","Poids libres"],
            ["Extension des poignets","Avant-bras","","Poids libres"],
            ["Flexion des poignets","Avant-bras","","Poids libres"],
            
            // TRAPEZES
            
            ["Shrug avec haltères","Trapèzes","","Poids libres"],
            ["Shrug a la barre","Trapèzes","","Poids libres"],
            ["Shrug a la machine","Trapèzes","","Machines, poulie"],
            ["Shrug a la poulie","Trapèzes","","Machines, poulie"],
            
            // TRICEPS
            ["Barre au front a la poulie","Triceps","","Machines, poulie"],
            ["Barre au front a la barre","Triceps","","Poids libres"],
            ["Developpe couche prise serree","Triceps","","Poids libres"],
            ["Dips a la machine","Triceps","","Machines, poulie"],
            ["Dips entre deux bancs","Triceps","","Poids du corps"],
            ["Dips prise serree","Triceps","","Poids du corps"],
            ["Extension a la poulie haute corde","Triceps","","Machines, poulie"],
            ["Extension a la poulie haute barre droite","Triceps","","Machines, poulie"],
            ["Extension nuque avec haltères","Triceps","","Poids libres"],
            ["Extension nuque a la poulie","Triceps","","Machines, poulie"],
            ["Kickback","Triceps","","Poids libres"],
            ["Kickback a la poulie","Triceps","","Machines, poulie"],
            ["Pompes prise diamant","Triceps","","Poids du corps"],
            ["Pompes prise serree","Triceps","","Poids du corps"],
            
            // LOMBAIRES
            ["Good morning","Lombaires","","Poids libres"],
            ["Extension au banc a lombaires","Lombaires","","Machines, poulie"],
            ["Souleve de terre a la poulie","Lombaires","","Machines, poulie"],
            
            // ISCHIO
            ["Leg curl","Ischio-Jambiers","","Machines, poulie"],
            
            // DORSAUX
            ["Traction prise large","Dorsaux","","Poids du corps"],
            ["Traction prise neutre","Dorsaux","","Poids du corps"],
            ["Traction prise serree en pronation","Dorsaux","","Poids du corps"],
            ["Traction prise serree en supination","Dorsaux","","Poids du corps"],
            ["Traction a la machine","Dorsaux","","Machines, poulie"],
            ["Traction a la poulie haute en pronation","Dorsaux","","Machines, poulie"],
            ["Traction a la poulie haute en supination","Dorsaux","","Machines, poulie"],
            ["Rowing assis a la poulie basse","Dorsaux","","Machines, poulie"],
            ["Rowing a la barre","Dorsaux","","Poids libres"],
            ["Rowing avec haltères","Dorsaux","","Poids libres"],
            
            
            // FESSIERS
            ["Souleve de terre","Fessiers","","Poids libres"],
            ["Souleve de terre sumo","Fessiers","","Poids libres"],
            ["Fente glissee","Fessiers","",""],
            ["Fente a la smith machine","Fessiers","","Machines, poulie"],
            
            // MOLLETS
            ["Chameau","Mollets","","Poids libres"],
            ["Mollets assis","Mollets","","Machines, poulie"],
            ["Mollets debout a la machine","Mollets","","Machines, poulie"],
            ["Mollets debout","Mollets","","Poids du corps"],
            
            // CARDIO
            ["Rameur","Cardio","","Cardio"],
            ["Velo elyptique","Cardio","","Cardio"],
            ["Tapis de course","Cardio","","Cardio"],
            
            
//            ["","Mollets","",""],
            ]
        
        defaultsExercices.forEach { (exercice) in
            _ = CoreDataManager.shared.createExercice(name: exercice[0], category: exercice[3], primaryGroup: exercice[1], secondaryGroup: exercice[2], training: nil)
        }
    }
    
}
