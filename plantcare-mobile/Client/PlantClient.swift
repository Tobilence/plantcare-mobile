//
//  PlantClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct PlantClient: ReadClient {
    
    var urlName = "plants"
    typealias Identifier = String
    typealias DecodableModel = Plant
    
}
