//
//  PlantClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 20.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct PlantClient: WebClient {
    
    typealias DecodableModel = Plant
    typealias EncodableModel = Plant
    typealias Identifier = String
    
    var resourceUrl: URL
    
    init() {
        guard let resourceUrl = URL(string: "https://plantcare.msgis.net/api/data/plants") else {
            fatalError()
        }
        self.resourceUrl = resourceUrl
    }
    
     func getSpecificUrl(id: String) -> URL {
        guard let resourceUrl = URL(string: "https://plantcare.msgis.net/api/data/plants?scientificName=\(id)") else {
            fatalError()
        }
        return resourceUrl
    }
}
