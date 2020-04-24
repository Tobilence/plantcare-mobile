//
//  UserClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 20.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct UserClient: WebClient {
    
    typealias DecodableModel = User
    typealias EncodableModel = User
    typealias Identifier = Int
    
    var resourceUrl: URL
    
    init() {
        guard let resourceUrl = URL(string: "https://plantcare.msgis.net/api/data/users") else {
            fatalError()
        }
        self.resourceUrl = resourceUrl
    }
    
    func getSpecificUrl(id: Int) -> URL {
        guard let resourceUrl = URL(string: "https://plantcare.msgis.net/api/data/users/\(id)") else {
            fatalError()
        }
        return resourceUrl
    }
}
