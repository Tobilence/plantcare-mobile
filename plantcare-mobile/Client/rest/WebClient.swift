//
//  WebClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

protocol WebClient {
    
    associatedtype Identifier
    var urlName: String { get }
}

extension WebClient {
    
    func baseUrl() -> URL {
        guard let url = URL(string: "https://plantcare.msgis.net/api/data/\(urlName)") else {
            print("Could not generate base url!")
            fatalError()
        }
        return url
    }
    
    func specificUrl(id: Identifier) -> URL {
        guard let url = URL(string: "https://plantcare.msgis.net/api/data/\(urlName)/\(id)") else {
            print("Could not generate specificurl!")
            fatalError()
        }
        return url
    }
}
