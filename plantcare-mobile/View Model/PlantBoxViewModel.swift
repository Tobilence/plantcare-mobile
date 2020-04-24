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
    var changesMade = false
    @Published var name: String {
        didSet {
            self.changesMade = true
        }
    }
    @Published var plants: [PlantViewModel] {
        didSet {
            self.changesMade = true
        }
    }
    var raspberryIdentifier: String? {
        didSet {
            self.changesMade = true
        }
    }
    @Published var location: (latitude: Double, longitude: Double) {
        didSet {
            self.changesMade = true
        }
    }
    @Published var users: [UserViewModel] {
        didSet {
            self.changesMade = true
        }
    }
    @Published var uiImage: UIImage? {
        didSet {
            self.changesMade = true
        }
    }
    
    var plantBoxClient = PlantBoxClient()
    
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
        self.changesMade = false
    }
    
    func updateDataToServer() {
        let preparedPlantBox = PreparedPlantBox(plantBoxViewModel: self)
        plantBoxClient.save(preparedPlantBox) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                print("plantBox saved successfully")
            }
        }
    }
}
