//
//  UneditablePlantBoxView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 18.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI
import MapKit

struct UneditablePlantBoxView: View {
    
    @EnvironmentObject var plantBoxViewModel: PlantBoxViewModel
    @EnvironmentObject var sensorViewModel: SensorViewModel
    @State var plantLocations: [MKPointAnnotation]
    @State private var showingSheet = false
    @State private var currentSheetType: SheetType? = nil
    @State private var detailPlantShowing: PlantViewModel?
    @State private var editable = false
    @State private var chartRangeSelected: Int = 1
    @State private var halfModalShowing = false
    @State private var sensorType: SensorType = .light
    var mockData: MockData = MockData()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack (alignment: .topTrailing){
                    //MapView
                    MapView(locations: $plantLocations, mainPlantBox: plantBoxViewModel.name)
                        .shadow(radius: 20)
                        .onTapGesture {
                            self.currentSheetType = .map
                            self.showingSheet = true
                    }
                    .frame(height: 200)
                }
                
                //PlantBoxImage
                if plantBoxViewModel.uiImage != nil {
                    Image(uiImage: plantBoxViewModel.uiImage!)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                        .overlay(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(Color.white, lineWidth: 2))
                        .offset(y: -75)
                        .aspectRatio(contentMode: .fill)
                        .padding([.top], 22)
                        .padding([.trailing, .leading], 75)
                        .shadow(radius: 5)
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
                    }
                }.offset(y: -75)
                
                //Sensor Measurements
                AllMeasurementsView(halfModalShowing: $halfModalShowing, sensorType: $sensorType)
                    .environmentObject(sensorViewModel)
                    .offset(y: -60)
            }
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
                    } else if self.currentSheetType == .weather {
                        Text("Weather goes here")
                    }
                    
                    Button (action: self.resetSheet) {
                        Text("Done")
                            .bold()
                    }
                    .padding()
                }
            }
            .padding(.top, 50)
            HalfModalView(isShown: $halfModalShowing) {
//               ACTUAL DATA:
//               LineChart(dataSet: self.sensorViewModel.lightData)
//                    .padding(.bottom, 120)
                
                
//               MOCK DATA:
                VStack {
                    Text(self.sensorType.rawValue)
                    Picker(selection: self.$chartRangeSelected, label: Text("Light History")) {
                        Text("Year").tag(3)
                        Text("Month").tag(2)
                        Text("Week").tag(1)
                        Text("Day").tag(0)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    LineChart(dataSet: self.mockData.sampleData(sampleType: self.sensorType, displayRange: ChartDisplayType(rawValue: self.chartRangeSelected)!), type: ChartDisplayType(rawValue: self.chartRangeSelected)!)
                        .padding(.bottom, 120)
                }
            }
        }
        .navigationBarTitle(plantBoxViewModel.name)
    }
    
    func resetSheet() {
        self.showingSheet = false
        self.detailPlantShowing = nil
        self.currentSheetType = nil
    }
    
    private enum SheetType {
        case map
        case plant
        case weather
    }
}

extension MKPointAnnotation {
    
    static func example() -> [MKPointAnnotation] {
        let example = MKPointAnnotation()
        example.coordinate = CLLocationCoordinate2D(latitude: 45.5, longitude: 16.3)
        example.title = "PlantBox1"
        return [example]
    }
}

struct UneditablePlantBoxView_Previews: PreviewProvider {
    static var previews: some View {
        UneditablePlantBoxView(plantLocations: MKPointAnnotation.example())
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
