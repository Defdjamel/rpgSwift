//
//  Arme.swift
//  OC_P3
//
//  Created by james on 13/05/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import Foundation
class Arme {
    var degats : Int
    let type : ArmeType
    
    init(_ type : ArmeType) {
        self.type = type
        switch self.type {
        case .Arc:
            self.degats = 10
        case .Epee:
            self.degats = 10
        case .Sceptre:
            self.degats = 10
        case .Special:
            self.degats =  Int.random(in: 5..<25)
       
        }
    }
}


enum ArmeType : String{
    case Arc = "Archer"
    case Sceptre = "Scéptre"
    case Epee = "Epée"
    case Special = "Arme Special"
}
