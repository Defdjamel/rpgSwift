//
//  Team.swift
//  OC_P3
//
//  Created by james on 13/05/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import Foundation
class Team{
    let personnages : [Personnage]
    let nom : String
    
    init(nom: String,  personnages: [Personnage]) {
     self.nom = nom
     self.personnages = personnages
    }
    
    /// Function check is one or more Charactere are stil alive
    ///
    /// - Returns: Boolean
    func isStillAlive() -> Bool {
        for personnage in personnages {
            if personnage.isAlive() {
                return true
            }
        }
        return false
    }
    
    func printResume(){
        print()
        print("Resumé de l'équipe : \(self.nom)")
        for perso in personnages {
            print(perso.resume())
        }
    }
}
