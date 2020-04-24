//
//  PlantCareModel.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 23.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

protocol PlantCareModel {
    
    associatedtype PrimaryKeyType
    var urlName: String { get }
}

extension PlantCareModel {
    
    func baseUrl() -> URL {
        guard let url = URL(string: "https://plantcare.msgis.net/api/data/\(urlName)") else {
            print("Could not generate base url!")
            fatalError()
        }
        return url
    }
    
    func specificUrl(identifier: PrimaryKeyType) -> URL {
        guard let url = URL(string: "https://plantcare.msgis.net/api/data/\(urlName)/\(identifier)") else {
            print("Could not generate specificurl!")
            fatalError()
        }
        return url
    }
}
