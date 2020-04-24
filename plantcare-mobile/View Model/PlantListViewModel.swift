//
//  PlantViewModel.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

final class PlantListViewModel: ObservableObject {
    
    @Published var plants:[Plant] = []
    let plantClient = PlantClient()
    
    init() {
        plantClient.getAll() { result in
            switch result {
                case .failure(let error):
                    print("Error occurred while trying to fetch plants: \(error)")
                case .success(let plants):
                    DispatchQueue.main.async {
                        self.plants = plants
                    }
            }
        }
    }
}
