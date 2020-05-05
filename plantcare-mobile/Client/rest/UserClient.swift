//
//  UserClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct UserClient: ReadWriteClient {
    
    var urlName = "users"
    typealias Identifier = Int
    typealias DecodableModel = User
    typealias EncodableModel = User
}
