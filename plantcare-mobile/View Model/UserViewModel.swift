//
//  UserViewModel.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import SwiftUI

final class UserViewModel: ObservableObject {
    
    var id: Int = -1
    var changesMade = false
    @Published var email: String = "" {
        didSet {
            changesMade = true
        }
    }
    @Published var firstName: String = "" {
        didSet {
            changesMade = true
        }
    }
    @Published var lastName: String = "" {
        didSet {
            changesMade = true
        }
    }
    @Published var editable = false
    @Published var uiImage: UIImage? = nil {
        didSet {
            changesMade = true
        }
    }
    
    let userService = UserService()
    
    ///gets the current user from the api and initializes the view model using it
    init() {
        userService.getUserInformation(forUserId: 14) { result in
            
            switch result {
            case .failure(let error):
                print(error)
            case.success(let user):
                DispatchQueue.main.async {
                    self.id = user.id
                    self.email = user.email
                    self.firstName = user.firstName
                    self.lastName = user.lastName
                    if let picture = user.picture {
                        self.uiImage = UIImage.fromBase64String(picture) ?? nil
                        if self.uiImage == nil {
                            print("Invalid base64 String for user: \(user.id)")
                        }
                    }
                    self.changesMade = false
                }
            }
            
        }
    }
    
    init(user: User) {
        self.id = user.id
        self.email = user.email
        self.firstName = user.firstName
        self.lastName = user.lastName
        if let picture = user.picture {
            self.uiImage = UIImage.fromBase64String(picture) ?? nil
            if self.uiImage == nil {
                print ("Invalid base64 String for user: \(user.id)")
            }
        }
        self.changesMade = false
    }
    
    func sendDataToServer() {
        let user = User(id: id, email: email, firstName: firstName, lastName: lastName, picture: uiImage?.convertToBase64String())
        userService.sendPost(user: user) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let user):
                print("User with id: \(user.id) sucessfully updated")
            }
        }
    }
}
