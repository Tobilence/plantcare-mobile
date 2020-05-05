//
//  LoginViewRouter.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 30.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

class LoginViewRouter: ObservableObject {
    
    @Published var plantBoxListLoaded = false
    @Published var plantListLoaded = false
    var plantBoxList: PlantBoxListViewModel?
    var plantList: PlantListViewModel?
    
    func startLoading() {
        self.plantBoxList = PlantBoxListViewModel(loginViewRouter: self)
        self.plantList = PlantListViewModel(loginViewRouter: self)
    }
}
