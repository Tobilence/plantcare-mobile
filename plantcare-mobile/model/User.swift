//
//  User.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let id: Int
    var email: String
    var firstName: String
    var lastName: String
    var picture: String?
}
