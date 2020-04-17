//
//  PlantBoxViewModel.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 15.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import UIKit

class PlantBoxViewModel: ObservableObject, Identifiable {
    
    var id: Int
    @Published var name: String
    @Published var plants: [PlantViewModel]
    var raspberryIdentifier: String?
    @Published var location: (latitude: Double, longitude: Double)
    @Published var users: [UserViewModel]
    @Published var uiImage: UIImage?
    
    init(plantBox: PlantBox) {
        id = plantBox.id
        name = plantBox.name
        plants = plantBox.plants.map {PlantViewModel(plant: $0)}
        raspberryIdentifier = plantBox.raspberryIdentifier
        location = (plantBox.latitude, plantBox.longitude)
        users = plantBox.users
                        .map { UserViewModel(user: $0) }
        if let picture = plantBox.picture {
            self.uiImage = UIImage.fromBase64String(picture) ?? nil
            if uiImage == nil {
                print("Invalid base64 String for PlantBox: \(plantBox.id)")
            }
        }
    }
}
