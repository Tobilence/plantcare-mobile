//
//  PlantBoxView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI
import MapKit

struct PlantBoxListView: View {
    
    @ObservedObject var plantBoxListViewModel = PlantBoxListViewModel()
    @EnvironmentObject var plantListViewModel: PlantListViewModel
    @State var loading = true
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            if plantBoxListViewModel.plantBoxes.count != 0 {
                List {
                    ForEach(plantBoxListViewModel.plantBoxes){
                        plantBox in
                        
                        HStack {
                            PlantBoxCellView()
                                .environmentObject(plantBox)
                            
                            NavigationLink (destination:
                                PlantBoxDetailView(plantLocations: self.plantBoxListViewModel.plantBoxes.map { plantBox in
                                    var annotation = MKPointAnnotation()
                                    annotation.coordinate = CLLocationCoordinate2D(latitude: plantBox.location.latitude, longitude: plantBox.location.longitude)
                                    annotation.title = plantBox.name
                                    return annotation
                                })
                                    .environmentObject(plantBox)
                                    .environmentObject(self.plantListViewModel)) {
                                        EmptyView()
                            }
                            .frame(width: 0)
                            .opacity(0)
                        }
                    }
                }
                .navigationBarTitle("PlantBoxes")
            } else {
                ActivityIndicator(shouldAnimate: self.$loading)
                    .navigationBarTitle("PlantBoxes")
            }
        }
    }
}

struct PlantBoxListView_Previews: PreviewProvider {
    static var previews: some View {
        PlantBoxListView()
    }
}
