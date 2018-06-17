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
            ["Développé couché barre", "Pectoraux", "Triceps", "Poids libres"],
            ["Développé couche haltères","Pectoraux","Triceps","Poids libres"],
            ["Développé incliné barre","Pectoraux","Triceps","Poids libres"],
            ["Développé incliné haltères","Pectoraux","Triceps","Poids libres"],
            ["Développé decliné barre","Pectoraux","Triceps","Poids libres"],
            ["Dips prise large buste penché","Pectoraux","Triceps","Poids du corps"],
            ["Pull over","Pectoraux","Triceps","Poids libres"],
            ["Pec deck","Pectoraux","Triceps","Machines, poulie"],
            ["Pompes prise large","Pectoraux","Triceps","Poids du corps"],
            ["Écarté à la machine","Pectoraux","Triceps","Machines, poulie"],
            ["Écarté couché haltères","Pectoraux","Triceps","Poids libres"],
            ["Écarté couché poulie","Pectoraux","Triceps","Machines, poulie"],
            ["Écarté decliné haltères","Pectoraux","Triceps","Poids libres"],
            ["Écarté decliné poulie","Pectoraux","Triceps","Machines, poulie"],
            ["Écarté incliné haltères","Pectoraux","Triceps","Poids libres"],
            ["Écarté incliné poulie","Pectoraux","Triceps","Machines, poulie"],
            
            // DELTOIDES DE BASE
            ["Développé militaire barre","Deltoïdes","","Poids libres"],
            ["Développé militaire haltères","Deltoïdes","","Poids libres"],
            ["Développé militaire machines","Deltoïdes","","Machines, poulie"],
            ["Développé nuque barre","Deltoïdes","","Poids libres"],
            ["Développé nuque haltères","Deltoïdes","","Poids libres"],
            ["Développé arnold","Deltoïdes","","Poids libres"],
            ["Élevations laterales haltères","Deltoïdes","","Poids libres"],
            ["Élevations laterales poulie","Deltoïdes","","Machines, poulie"],
            ["Élevations frontales haltères","Deltoïdes","","Poids libres"],
            ["Élevations frontales barre","Deltoïdes","","Poids libres"],
            ["Élevations frontales poulie","Deltoïdes","","Machines, poulie"],
            ["Rowing barre coudes ouverts","Deltoïdes","","Poids libres"],
            ["Rowing poulie coudes ouverts","Deltoïdes","","Machines, poulie"],
            ["Oiseau poulie","Deltoïdes","Trapèzes","Machines, poulie"],
            ["Oiseau haltères","Deltoïdes","Trapèzes","Poids libres"],
            
            // ABDOMINAUX
            ["Crunch","Abdominaux","","Poids du corps"],
            ["Crunch poulie haute","Abdominaux","","Machines, poulie"],
            ["Crunch à la machine","Abdominaux","","Machines, poulie"],
            ["Enroulement du bassin","Abdominaux","","Poids du corps"],
            ["Gainage planche","Abdominaux","","Gainage"],
            ["Gainage oblique","Abdominaux","","Gainage"],
            ["Flexions latérales","Abdominaux","","Poids du corps"],
            ["Obliques","Abdominaux","","Poids du corps"],
            
            // QUADRICEPS
            ["Hack squat","Quadriceps","","Poids libres"],
            ["Front squat barre","Quadriceps","","Poids libres"],
            ["Front squat smith machine","Quadriceps","","Machines, poulie"],
            ["Squat barre","Quadriceps","","Poids libres"],
            ["Squat smith machine","Quadriceps","","Machines, poulie"],
            ["Montées sur banc","Quadriceps","","Poids du corps"],
            ["Fentes à la smith machine","Quadriceps","","Machines, poulie"],
            ["Fentes avec haltères","Quadriceps","","Poids libres"],
            ["Leg extension","Quadriceps","","Machines, poulie"],
            
            // BICEPS
            ["Curl avec haltères","Biceps","","Poids libres"],
            ["Curl à la barre","Biceps","","Poids libres"],
            ["Curl à la poulie basse","Biceps","","Machines, poulie"],
            ["Curl incliné","Biceps","","Poids libres"],
            ["Curl marteau à la poulie basse","Biceps","","Machines, poulie"],
            ["Curl marteau avec haltères","Biceps","","Poids libres"],
            ["Curl pupitre à la poulie basse","Biceps","","Machines, poulie"],
            ["Curl pupitre avec haltères","Biceps","","Poids libres"],
            ["Curl pupitre à la barre","Biceps","","Poids libres"],
            ["Curl araignée avec haltères","Biceps","","Poids libres"],
            ["Curl araignée à la barre","Biceps","","Poids libres"],
            ["Curl concentré","Biceps","","Poids libres"],
            ["Curl à la poulie vis à vis","Biceps","","Machines, poulie"],
            
            // AVANT BRAS
            ["Curl inversé à la poulie","Avant-bras","","Machines, poulie"],
            ["Curl inversé avec haltères","Avant-bras","","Poids libres"],
            ["Curl inversé au pupitre","Avant-bras","","Poids libres"],
            ["Extension des poignets","Avant-bras","","Poids libres"],
            ["Flexion des poignets","Avant-bras","","Poids libres"],
            
            // TRAPEZES
            
            ["Shrug avec haltères","Trapèzes","","Poids libres"],
            ["Shrug à la barre","Trapèzes","","Poids libres"],
            ["Shrug à la machine","Trapèzes","","Machines, poulie"],
            ["Shrug à la poulie","Trapèzes","","Machines, poulie"],
            
            // TRICEPS
            ["Barre au front à la poulie","Triceps","","Machines, poulie"],
            ["Barre au front à la barre","Triceps","","Poids libres"],
            ["Développé couché prise serrée","Triceps","","Poids libres"],
            ["Dips à la machine","Triceps","","Machines, poulie"],
            ["Dips entre deux bancs","Triceps","","Poids du corps"],
            ["Dips prise serrée","Triceps","","Poids du corps"],
            ["Extension à la poulie haute corde","Triceps","","Machines, poulie"],
            ["Extension à la poulie haute barre droite","Triceps","","Machines, poulie"],
            ["Extension nuque avec haltères","Triceps","","Poids libres"],
            ["Extension nuque à la poulie","Triceps","","Machines, poulie"],
            ["Kickback","Triceps","","Poids libres"],
            ["Kickback à la poulie","Triceps","","Machines, poulie"],
            ["Pompes prise diamant","Triceps","","Poids du corps"],
            ["Pompes prise serrée","Triceps","","Poids du corps"],
            
            // LOMBAIRES
            ["Good morning","Lombaires","","Poids libres"],
            ["Extension au banc à lombaires","Lombaires","","Machines, poulie"],
            ["Soulevé de terre à la poulie","Lombaires","","Machines, poulie"],
            
            // ISCHIO
            ["Leg curl","Ischio-Jambiers","","Machines, poulie"],
            
            // DORSAUX
            ["Traction prise large","Dorsaux","","Poids du corps"],
            ["Traction prise neutre","Dorsaux","","Poids du corps"],
            ["Traction prise serrée en pronation","Dorsaux","","Poids du corps"],
            ["Traction prise serrée en supination","Dorsaux","","Poids du corps"],
            ["Traction à la machine","Dorsaux","","Machines, poulie"],
            ["Traction à la poulie haute en pronation","Dorsaux","","Machines, poulie"],
            ["Traction à la poulie haute en supination","Dorsaux","","Machines, poulie"],
            ["Rowing assis à la poulie basse","Dorsaux","","Machines, poulie"],
            ["Rowing à la barre","Dorsaux","","Poids libres"],
            ["Rowing avec haltères","Dorsaux","","Poids libres"],
            
            
            // FESSIERS
            ["Soulevé de terre","Fessiers","","Poids libres"],
            ["Soulevé de terre sumo","Fessiers","","Poids libres"],
            ["Fentes glissées","Fessiers","","Poids du corps"],
            ["Fentes à la smith machine","Fessiers","","Machines, poulie"],
            
            // MOLLETS
            ["Chameau","Mollets","","Poids libres"],
            ["Mollets assis","Mollets","","Machines, poulie"],
            ["Mollets debout à la machine","Mollets","","Machines, poulie"],
            ["Mollets debout","Mollets","","Poids du corps"],
            
            // CARDIO
            ["Rameur","Cardio","","Cardio"],
            ["Vélo elliptique","Cardio","","Cardio"],
            ["Vélo de course","Cardio","","Cardio"],
            ["Marcheur","Cardio","","Cardio"],
            ["Mountain climber","Cardio","","Cardio"],
            ["Tapis de course","Cardio","","Cardio"],
            
            
//            ["","Mollets","",""],
            ]
        
        defaultsExercices.forEach { (exercice) in
            _ = CoreDataManager.shared.createExercice(name: exercice[0], category: exercice[3], primaryGroup: exercice[1], secondaryGroup: exercice[2], training: nil)
        }
    }
    
}
