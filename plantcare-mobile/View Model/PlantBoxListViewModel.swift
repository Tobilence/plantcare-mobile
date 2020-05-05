//
//  PlantBoxListViewModel.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 15.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

class PlantBoxListViewModel: ObservableObject {
    
    @Published var plantBoxes:[PlantBoxViewModel] = []
    var plantBoxClient = PlantBoxClient()
    let loginViewRouter: LoginViewRouter
    
    init(loginViewRouter: LoginViewRouter) {
        self.loginViewRouter = loginViewRouter
        plantBoxClient.getAllForUser(withId: 14) { result in
            switch result {
                case .failure(let error):
                    print("Error occurred while trying to fetch plants: \(error)")
                case .success(let plantBoxes):
                    DispatchQueue.main.async {
                        self.plantBoxes = plantBoxes.map { PlantBoxViewModel(plantBox: $0) }
                        self.loginViewRouter.plantBoxListLoaded = true
                    }
            }
        }
    }
    
    func didFinishLoading() -> Bool {
        print("plantBox: \(plantBoxes.count)")
        return plantBoxes.count > 0
    }
}
