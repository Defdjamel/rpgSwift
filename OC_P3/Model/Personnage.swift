//
//  Personnage.swift
//  OC_P3
//
//  Created by james on 13/05/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//


class Personnage {
    var nom: String
    let type: PersoType
    let arme : Arme
    var life: Int
    let lifeCanRecover: Int
    
    init(nom: String, type : PersoType) {
        self.nom = nom
        self.type = type
        
        switch self.type {
        case .Archer:
            self.life = 10
            self.lifeCanRecover = 10
            self.arme = Arme.init(.Arc)
        case .Guerrier:
            self.life = 10
            self.lifeCanRecover = 5
             self.arme = Arme.init(.Epee)
        case .Mage:
            self.life = 10
            self.lifeCanRecover = 15
             self.arme = Arme.init(.Sceptre)
        }
    
    }
    
    func resume() -> String {
        if self.life > 0 {
                return " \(self.nom) (\(self.type.rawValue) , vie: \(self.life))"
        }else{
            return " \(self.nom) (\(self.type.rawValue) , Mort!)"
        }
    
    }
    
    func isAlive() -> Bool{
        return self.life > 0
    }
}

//MARK: -  Attaque
extension Personnage{
    func attack(_ personnage: Personnage){
        personnage.life -= self.arme.degats
        print( "💣 \(self.nom) enleve \(self.arme.degats) points de vies  à \(personnage.resume())")
        if personnage.life <= 0 {
            print( "\(personnage.nom) est mort !!!")
        }
        
    }
    func attackSpecial(_ specialWeapon : Arme,  _ personnage: Personnage){
        personnage.life -= specialWeapon.degats
        print( "💣 \(self.nom) enleve \(specialWeapon.degats) points de vies  à \(personnage.resume())")
        if personnage.life <= 0 {
            print( "\(personnage.nom) est mort !!!")
        }
    }
    
    func recoverLife(_ personnage: Personnage){
        personnage.life += self.lifeCanRecover
        print(" ❤️ \(self.nom) ajoute \(self.lifeCanRecover) points de vies  à \(personnage.resume())")
    }
}
