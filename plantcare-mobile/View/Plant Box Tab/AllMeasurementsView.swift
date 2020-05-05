//
//  AllMeasurementsView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 25.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct AllMeasurementsView: View {
    
    @EnvironmentObject var sensorViewModel: SensorViewModel
    @Binding var halfModalShowing: Bool
    @Binding var sensorType: SensorType
    
    
    var body: some View {
        VStack (spacing: 10){
            Text("Measurements")
                .font(.headline)
                .fontWeight(.light)
            HStack (spacing: 75) {
                MeasurementView(measurementName: "Temperature", unit: "°C", value: sensorViewModel.latestData.temperature)
                    .onTapGesture {
                        self.sensorType = .temperature
                        self.halfModalShowing = true
                    }
                MeasurementView(measurementName: "Ground Humidity", unit: "%", value: sensorViewModel.latestData.groundHumidity)
                    .onTapGesture {
                        self.sensorType = .groundHumidity
                        self.halfModalShowing = true
                    }
            }
            HStack (spacing: 75) {
                MeasurementView(measurementName: "Air Pressure", unit: "hPa", value: sensorViewModel.latestData.airPressure)
                    .onTapGesture {
                        self.sensorType = .airPressure
                        self.halfModalShowing = true
                }
                MeasurementView(measurementName: "Brightness", unit: "Lux", value: sensorViewModel.latestData.light)
                    .onTapGesture {
                        self.sensorType = .light
                        self.halfModalShowing = true
                }
            }
        }
    }
}
