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
    @State private var showFullImage = false
    @State var plantLocations:[MKPointAnnotation]
    @State private var showingSheet = false
    @State private var currentSheetType: SheetType? = nil
    @State private var detailPlantShowing: PlantViewModel?
    
    var body: some View {
        ScrollView {
            //MapView
            MapView(locations: $plantLocations, mainPlantBox: plantBoxViewModel.name)
                .shadow(radius: 20)
                .onTapGesture {
                    self.currentSheetType = .map
                    self.showingSheet = true
            }
            .frame(height: 200)
            
            //PlantBoxImage
            if plantBoxViewModel.uiImage != nil {
                Image(uiImage: plantBoxViewModel.uiImage!)
            } else {
                Image("plantbox-placeholder")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                    .overlay(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(Color.white, lineWidth: 2))
                    .offset(y: -75)
                    .aspectRatio(contentMode: .fit)
                    .padding([.top], 22)
                    .padding([.trailing, .leading], 75)
                    .shadow(radius: 5)
            }
            
            //Plants
            VStack (spacing: 5) {
                Text("Plants")
                    .font(.headline)
                    .fontWeight(.light)
                HStack (spacing: 10) {
                    ForEach(plantBoxViewModel.plants) { plant in
                        Image(base64String: plant.picture)
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .onTapGesture {
                                self.detailPlantShowing = plant
                                self.currentSheetType = .plant
                                self.showingSheet = true
                            }
                    }
                    Button(action: addPlant){
                        Image(systemName: "plus")
                            .resizable()
                            .padding()
                            .foregroundColor(.blue)
                    }
                    .frame(width: 70, height: 70)
                    .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 2, dash: [10])))
                    .foregroundColor(.blue)
                }
            }.offset(y: -75)
            
            
            //Sensor Measurements
            VStack (spacing: 10){
                Text("Measurements")
                    .font(.headline)
                    .fontWeight(.light)
                HStack (spacing: 75) {
                    MeasurementView(measurementName: "Temperature", unit: "°C", value: 22.5)
                    MeasurementView(measurementName: "Ground Humidity", unit: "%", value: 48.2)
                }
                HStack (spacing: 75) {
                    MeasurementView(measurementName: "Air Pressure", unit: "hPa", value: 1.23)
                    MeasurementView(measurementName: "Brightness", unit: "Lux", value: 73)
                }
            }.offset(y: -60)
            
        }
        .navigationBarTitle(plantBoxViewModel.name)
        .sheet(isPresented: $showingSheet, onDismiss: resetSheet) {
            ZStack (alignment: .topTrailing) {
                if self.currentSheetType == .map {
                    ZStack {
                        MapView(locations: self.$plantLocations)
                    }
                } else if self.currentSheetType == .plant {
                    VStack {
                        Text(self.detailPlantShowing!.trivialName)
                            .font(.largeTitle)
                            .bold()
                            .offset(y: 15)
                            PlantDetailView()
                                .environmentObject(self.detailPlantShowing!)
                    }
                }
                
                Button (action: self.resetSheet) {
                    Text("Done")
                        .bold()
                }
                .padding()
            }
        }
    }
    
    func addPlant() {
        print("Plant will be added")
    }
    
    func resetSheet() {
        self.showingSheet = false
        self.detailPlantShowing = nil
        self.currentSheetType = nil
    }
    
    private enum SheetType {
        case map
        case plant
    }
}





//Preview

extension MKPointAnnotation {
    
    static func example() -> [MKPointAnnotation] {
        let example = MKPointAnnotation()
        example.coordinate = CLLocationCoordinate2D(latitude: 45.5, longitude: 16.3)
        example.title = "PlantBox1"
        return [example]
    }
}

struct PlantBoxDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlantBoxDetailView(plantLocations: MKPointAnnotation.example())
            .environmentObject(
                PlantBoxViewModel(plantBox:
                    PlantBox(
                        id: 1,
                        name: "Blumenkiste",
                        plants: [
                            
                        ],
                        raspberryIdentifier: "Identifier",
                        latitude: 24.2423,
                        longitude: 12.232,
                        users: [],
                        picture: nil)
                )
        )
        
    }
}
