//
//  Game.swift
//  OC_P3
//
//  Created by james on 13/05/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import Foundation
protocol gameProtocol {
    func gameEnd()
}

class Game {
    var team_1 : Team
    var team_2 : Team
    var maxPersoTeam = 1
    var tourIndex = 1
    
    init(){
        print("********* Création des équipes ********* ")
        self.team_1 = Game.creeEquipe(maxPersoTeam, "1")
        print()
        self.team_2 = Game.creeEquipe(maxPersoTeam, "2")
        
        
    }
    
    /// Function do next action
    func nextTour(){
        let teamPlaying = (tourIndex % 2 == 0 ) ? team_1 : team_2
        let teamReceiving = (tourIndex % 2 == 0 ) ? team_2 : team_1
        playTour(teamPlaying,teamReceiving)
        tourIndex += 1
        //special offer random
        if  teamReceiving.isStillAlive() && Int.random(in: 5..<25) > 8 {
              playTourWithSpecialOffer(teamPlaying, teamReceiving)
            tourIndex += 1
        }
      
       
    }
    
    /// function check if one team is die
    ///
    /// - Returns: Boolean
    func isPlaying() -> Bool {
        return team_1.isStillAlive() && team_2.isStillAlive()
    }
    
    /// function ask user to play action with his team
    ///
    /// - Parameters:
    ///   - teamPlaying: team player
    ///   - teamReceiving: other team
    func playTour(_ teamPlaying : Team, _ teamReceiving : Team ){
        print()
        print("***** Action \(tourIndex), Tour équipe : \(teamPlaying.nom) *****")
        //Select character
        let perso  = Game.selectPersonnage(teamPlaying)
        let action = Game.selectAction()
        let teamReceiveAction : Team
        switch action {
        case .Attack:
            print()
            print("Qui voulez-vous attaquer ? ")
            teamReceiveAction = teamReceiving
            let persoReceivingAction  = Game.selectPersonnage(teamReceiveAction)
            perso.attack(persoReceivingAction)
        case .Recover:
            print()
            print("Qui voulez-vous soigner ? ")
            teamReceiveAction = teamPlaying
            let persoReceivingAction  = Game.selectPersonnage(teamReceiveAction)
            perso.recoverLife(persoReceivingAction)
        }
    }
    
    
    func playTourWithSpecialOffer(_ teamPlaying : Team, _ teamReceiving : Team){
        print()
        print("***** Action \(tourIndex), Tour équipe : \(teamPlaying.nom) *****")
        print("🎁🎁🎁🎁🎁 Un coffre contenant une arme Spécial est apparut ! 🎁🎁🎁🎁")
        print("Voulez vous l'utiliser ou utiliser votre arme par default")
        
        let input = Game.selectActionCoffre()
        if !input {
            return
        }
        //display special weapon
        let specialWeapon = Arme.init(.Special)
        print()
        print("\(specialWeapon.type.rawValue) , dégat : \(specialWeapon.degats)")
        
        //Select character
        let perso  = Game.selectPersonnage(teamPlaying)
        print()
        print("Qui voulez-vous attaquer ? ")
        let persoReceivingAction  = Game.selectPersonnage(teamReceiving)
        perso.attackSpecial(specialWeapon, persoReceivingAction)
    }
    
    func displayResumeEndGame(){
        print()
        print("****** Fin de jeu  ******")
        let teamWin = team_1.isStillAlive() ? team_1 : team_2
        print(" équipe \(teamWin.nom) gagnante !")
        teamWin.printResume()
        print(" parti terminé en  \(tourIndex) tours !")
    }
    
}


//MARK: - Static Function
extension Game{
    
    /// Function to detect out of range on  User input selection from Array
    ///
    /// - Parameters:
    ///   - input: input user
    ///   - choices: Array of any
    /// - Returns: Bool
   static func isChoiceValid(_ input : Int, _ choices : [Any] )-> Bool{
        return Array(0...choices.count - 1 ).contains(input)
    }
    
    //
    /// Function can create team by added Characters to team
    ///
    /// - Parameters:
    ///   - nbrPerso: charactere number
    ///   - nameEquipe: team name
    /// - Returns: array of Characters
   static func creeEquipe(_ nbrPerso: Int , _ nameEquipe : String)-> Team{
        var personnages : [Personnage] =  []
        var types = [PersoType.Archer,PersoType.Guerrier,PersoType.Mage]
        // On demande quel type de personnage les joueurs veulent ajouter a leur equipe et leur nom
        for i in 1...nbrPerso {
            print("Equipe : \(nameEquipe)")
            print("Type du personnage n°\(i)")
            for j in 0..<types.count {
                let type = types[j]
                print("\(j + 1). \(type)")
            }
            //on demande le type tant qu'il est pas valide
            var inputType : Int
            repeat {
                inputType = input() - 1
                
                if !isChoiceValid(inputType, types){
                    print("Erreur! Entrez une valeur correct:")
                }
                
            } while !isChoiceValid(inputType, types)
            
            let typePerso = types[inputType]
            
            print("Nom du personnage : ")
            let namePerso = inputString()
            let perso = Personnage.init(nom: namePerso, type: typePerso)
            personnages.append(perso)
        }
        
        return Team.init(nom: nameEquipe, personnages: personnages)
    }
    
    
    /// Function ask to user to select a charactere in team
    ///
    /// - Parameter team: array of charaters
    /// - Returns: character selected
   static func selectPersonnage(_ team: Team ) -> Personnage {
        var persoSelected : Personnage?
        var inputPerso : Int
        
        print("Choix personnage : ")
        repeat {
            for i in 0..<team.personnages.count {
                let perso = team.personnages[i]
                print("\(i + 1). \(perso.resume())")
            }
            inputPerso = input() - 1
            if !isChoiceValid(inputPerso, team.personnages){
                print("Erreur! Entrez une valeur correct:")
            }else{
                persoSelected = team.personnages[inputPerso]
            }
            
        }while persoSelected == nil
        
        return persoSelected!
    }
    
    
    /// Function ask Action : Attak or recover life
    ///
    /// - Returns: actionType
   static func selectAction() -> ActionPersoType {
        print("Choix Action : ")
        var types : [ActionPersoType] = [.Attack,.Recover]
        var actionSelected : ActionPersoType
        var inputAction : Int
        for j in 0..<types.count {
            let type = types[j]
            print("\(j + 1). \(type)")
        }
        
        repeat {
            inputAction = input() - 1
            if !isChoiceValid(inputAction, types){
                print("Erreur! Entrez une valeur correct:")
            }
            actionSelected = types[inputAction]
        } while !isChoiceValid(inputAction, types)
        
        return actionSelected
    }

    /// Function ask to use special weapons
    ///
    /// - Returns: Bool
    static func selectActionCoffre() -> Bool{
        print("1. Utiliser cette arme spéciale")
        print("2. Non merci.")
        var inputAction : Int
        repeat {
            inputAction = input()
          
        } while inputAction != 1 && inputAction != 2
      
        switch inputAction {
        case 1:
            return true
        default:
            return false
        }
    }
}
