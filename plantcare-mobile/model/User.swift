//
//  User.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    
    let id: Int
    var email: String
    var firstName: String
    var lastName: String
    var picture: String?
    
    init(userViewModel: UserViewModel) {
        self.id = userViewModel.id
        self.email = userViewModel.email
        self.firstName = userViewModel.firstName
        self.lastName = userViewModel.lastName
        if let image = userViewModel.uiImage {
            self.picture = UIImage.convertToBase64String(image)()
        } else {
            self.picture = nil
        }
    }
    
    init(id: Int, email: String, firstName: String, lastName: String, picture: String?) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
    }
}
