//
//  PlantBox.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 15.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import UIKit

///The struct being used to receive plant boxes from the server
struct PlantBox : Decodable {
    
    var id: Int
    var name: String
    var plants: [Plant]
    var raspberryIdentifier: String?
    var latitude: Double
    var longitude: Double
    var users: [User]
    var picture: String?
}

///The struct being used to send plantBoxes to the Server
struct PreparedPlantBox : Encodable {
    
    var id: Int
    var name: String
    var plantNames: [String]
    var raspberryIdentifier: String?
    var latitude: Double
    var longitude: Double
    var users: [User]
    var picture: String?
    
    init(plantBoxViewModel: PlantBoxViewModel) {
        id = plantBoxViewModel.id
        name = plantBoxViewModel.name
        plantNames = plantBoxViewModel.plants.map{ $0.scientificName }
        raspberryIdentifier = plantBoxViewModel.raspberryIdentifier
        latitude = plantBoxViewModel.location.latitude
        longitude = plantBoxViewModel.location.longitude
        users = plantBoxViewModel.users.map {User(userViewModel: $0)}
        if let image = plantBoxViewModel.uiImage {
            picture = image.convertToBase64String()
        } else {
            picture = nil
        }
    }
}
