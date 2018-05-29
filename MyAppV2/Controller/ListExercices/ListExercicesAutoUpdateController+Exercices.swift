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
            ["Développé couché barre", "Pectoraux", "Triceps", "Poids libre"],
            ["Développé couché haltères","Pectoraux","Triceps","Poids libre"],
            ["Développé incliné barre","Pectoraux","Triceps",""],
            ["Développé incliné haltères","Pectoraux","Triceps",""],
            ["Développé décliné barre","Pectoraux","Triceps",""],
            ["Dips prise large buste penché","Pectoraux","Triceps","Poids du corps"],
            ["Pull over","Pectoraux","Triceps",""],
            ["Pec deck","Pectoraux","Triceps",""],
            ["Pompes prise large","Pectoraux","Triceps",""],            
            ["Écarté à la machine","Pectoraux","Triceps",""],
            ["Écarté couché haltères","Pectoraux","Triceps",""],
            ["Écarté couché poulie","Pectoraux","Triceps",""],
            ["Écarté décliné haltères","Pectoraux","Triceps",""],
            ["Écarté décliné poulie","Pectoraux","Triceps",""],
            ["Écarté incliné haltères","Pectoraux","Triceps",""],
            ["Écarté incliné poulie","Pectoraux","Triceps",""],
            
            // DELTOIDES DE BASE
            ["Développé militaire barre","Deltoïdes","",""],
            ["Développé militaire haltères","Deltoïdes","",""],
            ["Développé militaire machines","Deltoïdes","",""],
            ["Développé nuque barre","Deltoïdes","",""],
            ["Développé nuque haltères","Deltoïdes","",""],
            ["Développé arnold","Deltoïdes","",""],
            ["Élévations latérales haltères","Deltoïdes","",""],
            ["Élévations latérales poulie","Deltoïdes","",""],
            ["Élévations frontales haltères","Deltoïdes","",""],
            ["Élévations frontales barre","Deltoïdes","",""],
            ["Élévations frontales poulie","Deltoïdes","",""],
            ["Rowing barre coudes ouverts","Deltoïdes","",""],
            ["Rowing poulie coudes ouverts","Deltoïdes","",""],
            ["Oiseau poulie","Deltoïdes","Trapèzes",""],
            ["Oiseau haltères","Deltoïdes","Trapèzes",""],
            
            // ABDOMINAUX
            ["Crunch","Abdominaux","",""],
            ["Crunch poulie haute","Abdominaux","",""],
            ["Crunch à la machine","Abdominaux","",""],
            ["Enroulement du bassin","Abdominaux","",""],
            ["Gainage planche","Abdominaux","","Gainage"],
            ["Gainage oblique","Abdominaux","","Gainage"],
            ["Flexions latérales","Abdominaux","",""],
            ["Obliques","Abdominaux","",""],
            
            // QUADRICEPS
            ["Hack squat","Quadriceps","",""],
            ["Front squat barre","Quadriceps","",""],
            ["Front squat smith machine","Quadriceps","",""],
            ["Squat barre","Quadriceps","",""],
            ["Squat smith machine","Quadriceps","",""],
            ["Montée sur banc","Quadriceps","",""],
            ["Fente à la smith machine","Quadriceps","",""],
            ["Fente avec haltères","Quadriceps","",""],
            ["Leg extension","Quadriceps","",""],
            
            // BICEPS
            ["Curl avec haltères","Biceps","",""],
            ["Curl à la barre","Biceps","",""],
            ["Curl à la poulie basse","Biceps","",""],
            ["Curl incliné","Biceps","",""],
            ["Curl marteau à la poulie basse","Biceps","",""],
            ["Curl marteau avec haltères","Biceps","",""],
            ["Curl pupitre à la poulie basse","Biceps","",""],
            ["Curl pupitre avec haltères","Biceps","",""],
            ["Curl pupitre à la barre","Biceps","",""],
            ["Curl araignée avec haltères","Biceps","",""],
            ["Curl araignée à la barre","Biceps","",""],
            ["Curl concentré","Biceps","",""],
            ["Curl à la poulie vis à vis","Biceps","",""],
            
            // AVANT BRAS
            ["Curl inversé à la poulie","Avant-bras","",""],
            ["Curl inversé avec haltères","Avant-bras","",""],
            ["Curl inversé au pupitre","Avant-bras","",""],
            ["Extension des poignets","Avant-bras","",""],
            ["Flexion des poignets","Avant-bras","",""],
            
            // TRAPEZES
            
            ["Shrug avec haltères","Trapèzes","",""],
            ["Shrug à la barre","Trapèzes","",""],
            ["Shrug à la machine","Trapèzes","",""],
            ["Shrug à la poulie","Trapèzes","",""],
            
            // TRICEPS
            ["Barre au front à la poulie","Triceps","",""],
            ["Barre au front à la barre","Triceps","",""],
            ["Développé couché prise serrée","Triceps","",""],
            ["Dips à la machine","Triceps","",""],
            ["Dips entre deux bancs","Triceps","",""],
            ["Dips prise serrée","Triceps","",""],
            ["Extension à la poulie haute corde","Triceps","",""],
            ["Extension à la poulie haute barre droite","Triceps","",""],
            ["Extension nuque avec haltères","Triceps","",""],
            ["Extension nuque à la poulie","Triceps","",""],
            ["Kickback","Triceps","",""],
            ["Kickback à la poulie","Triceps","",""],
            ["Pompes prise diamant","Triceps","",""],
            ["Pompes prise serrée","Triceps","",""],
            
            // LOMBAIRES
            ["Good morning","Lombaires","",""],
            ["Extension au banc à lombaires","Lombaires","",""],
            ["Soulevé de terre à la poulie","Lombaires","",""],
            
            // ISCHIO
            ["Leg curl","Ischio-Jambiers","",""],
            
            // DORSAUX
            ["Traction prise large","Dorsaux","",""],
            ["Traction prise neutre","Dorsaux","",""],
            ["Traction prise serrée en pronation","Dorsaux","",""],
            ["Traction prise serrée en supination","Dorsaux","",""],
            ["Traction à la machine","Dorsaux","",""],
            ["Traction à la poulie haute en pronation","Dorsaux","",""],
            ["Traction à la poulie haute en supination","Dorsaux","",""],
            ["Rowing assis à la poulie basse","Dorsaux","",""],
            ["Rowing à la barre","Dorsaux","",""],
            ["Rowing avec haltères","Dorsaux","",""],
            
            
            // FESSIERS
            ["Soulevé de terre","Fessiers","",""],
            ["Soulevé de terre sumo","Fessiers","",""],
            ["Fente glissée","Fessiers","",""],
            ["Fente à la smith machine","Fessiers","",""],
            
            // MOLLETS
            ["Chameau","Mollets","",""],
            ["Mollets assis","Mollets","",""],
            ["Mollets debout à la machine","Mollets","",""],
            ["Mollets debout","Mollets","",""],
            ["","Mollets","",""],
            ]
        
        defaultsExercices.forEach { (exercice) in
            _ = CoreDataManager.shared.createExercice(name: exercice[0], category: exercice[3], primaryGroup: exercice[1], secondaryGroup: exercice[2], training: nil)
        }
    }
    
}
