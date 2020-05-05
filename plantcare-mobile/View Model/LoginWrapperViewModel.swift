//
//  LoginWrapperViewModel.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 29.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

class LoginWrapperViewModel : ObservableObject {
    
    @Published var plantBoxListViewModel: PlantBoxListViewModel? = nil
    @Published var plantListViewModel: PlantListViewModel? = nil
    
    func didFinishLoading() -> Bool {
        print("didfinish called")
        if let plantBoxList = plantListViewModel, let plantList = plantListViewModel {
            return plantBoxList.didFinishLoading() && plantList.didFinishLoading()
        }
        return false
    }
}
