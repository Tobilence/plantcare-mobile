//
//  PlantBoxDetailView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 15.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI
import MapKit

struct PlantBoxDetailView: View {
    
    @EnvironmentObject var plantBoxViewModel: PlantBoxViewModel
    @EnvironmentObject var plantListViewModel: PlantListViewModel
    @State var plantLocations: [MKPointAnnotation]
    @State private var editable = false
    
    var body: some View {
        ZStack {
            if !editable {
                UneditablePlantBoxView(plantLocations: plantLocations)
                    .environmentObject(plantBoxViewModel)
            }
            else {
                ZStack {
                    UneditablePlantBoxView(plantLocations: plantLocations)
                        .environmentObject(plantBoxViewModel)
                        .blur(radius: 5)
                        .opacity(0.3)
                    EditablePlantBoxView()
                        .environmentObject(plantBoxViewModel)
                        .transition(.opacity)
                }
            }
        }
        .navigationBarItems(trailing:
            HStack (spacing: 15) {
                if editable {
                    Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.editable.toggle()
                            }
                    }) {
                        Text("Cancel")
                    }
                }
                Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.editable.toggle()
                            if self.plantBoxViewModel.changesMade {
                                self.plantBoxViewModel.updateDataToServer()
                            }
                        }
                }) {
                    Text(editable ? "Save" : "Edit")
                }
            }
        )
    }
    
}





//Preview

struct PlantBoxDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlantBoxDetailView(plantLocations: MKPointAnnotation.example())
    }
}
