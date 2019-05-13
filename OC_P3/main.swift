//
//  main.swift
//  OC_P3
//
//  Created by james on 13/05/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import Foundation
let game : Game



// Function ask to user to enter an integer
func input() -> Int {
    let strData = readLine();
    guard let selection = Int(strData!) else{
        print("erreur selection")
       return input()
        
    }
    return selection
}


// Function ask to user to enter a string
func inputString() -> String {
    let strData = readLine();

    return strData!
}


//START A New Game
game = Game.init()


repeat {
    game.nextTour()
}while game.isPlaying()

game.displayResumeEndGame()
