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
    
    @ObservedObject
    var plantBoxListViewModel = PlantBoxListViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
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
                                .environmentObject(plantBox)){
                                    EmptyView()
                        }
                        .frame(width: 0)
                        .opacity(0)
                    }
                }
            }
            .navigationBarTitle("PlantBoxes")
        }
    }
}

struct PlantBoxListView_Previews: PreviewProvider {
    static var previews: some View {
        PlantBoxListView()
    }
}
