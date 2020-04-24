//
//  Plant.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct Plant: Decodable, Identifiable{
    
    var id: String {
        get {
            return scientificName
        }
    }
    let scientificName: String
    let trivialName: String
    let description: String
    let picture: String
}
