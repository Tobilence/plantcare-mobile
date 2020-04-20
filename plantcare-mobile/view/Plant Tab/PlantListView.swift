//
//  PlantsView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct PlantListView: View {
    
    @State private var loading: Bool = true
    @State private var searchTerm: String = ""
    @EnvironmentObject var plantListViewModel: PlantListViewModel
    
    var body: some View {
        NavigationView {
            if plantListViewModel.plants.count != 0 {
                List {
                    SearchBar(text: $searchTerm)
                    ForEach(plantListViewModel.plants.filter{
                        self.searchTerm.isEmpty ? true : $0.trivialName.localizedCaseInsensitiveContains(self.searchTerm)
                    }) { plant in
                        NavigationLink(destination: PlantDetailView()
                            .environmentObject(PlantViewModel(plant: plant))) {
                                PlantCellView(width:100, height: 80)
                                    .environmentObject(PlantViewModel(plant: plant))
                        }
                    }
                }
                .navigationBarTitle(Text("Plants"))
            } else {
                ActivityIndicator(shouldAnimate: self.$loading)
            }
        }
    }
}

struct PlantListView_Previews: PreviewProvider {
    static var previews: some View {
        PlantListView()
    }
}
