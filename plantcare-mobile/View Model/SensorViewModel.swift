//
//  SensorViewModel.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 25.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import Charts

class SensorViewModel: ObservableObject {
    
    @Published var latestData: (light: Double, groundHumidity: Double, airPressure: Double, temperature: Double) = (-1, -1, -1, -1)
    var latestDataClient = LatestDataSensorClient(id: 30)
    var lightSensorClient = MeasurementClient(measurementName: "light", id: 30)
    var temperatureClient = MeasurementClient(measurementName: "temperature", id: 30)
    var airPressureClient = MeasurementClient(measurementName: "airPressure", id: 30)
    var groundHumidity = MeasurementClient(measurementName: "groundHumidity", id: 30)
    @Published var lightData: [(x: Double, y: Double)] = []
    

    init() {
        latestDataClient.startListening(handler: latestDataUpdated)
        lightSensorClient.startListening(handler: lightDataUpdate)
    }
    
    deinit {
        latestDataClient.stopListening()
        lightSensorClient.stopListening()
    }
    
    func latestDataUpdated(id: String?, event: String?, data:String?) {
        guard let jsonData = data!.data(using: .utf8) else {
            print("error creating jsonData")
            return
        }
        do {
            let result = try JSONDecoder().decode(AllSensorValue.self, from: jsonData)
            DispatchQueue.main.async {
                self.latestData.light = result.light.value
                self.latestData.temperature = result.temperature.value
                self.latestData.airPressure = result.airPressure.value
                self.latestData.groundHumidity = result.groundHumidity.value
                print("latestData updated")
            }
        } catch {
            print(error)
        }
        
    }
    
    func lightDataUpdate (id: String?, event: String?, data:String?) {
        
        guard let jsonData = data!.data(using: .utf8) else {
            print("error creating jsonData")
            return
        }
        do {
            let result = try JSONDecoder().decode([SensorValue].self, from: jsonData)
            DispatchQueue.main.async {
                
                var dataArray:[(x: Double, y: Double)] = []
                for (index, sensorValue) in result.enumerated() {
                    dataArray.append((x: Double(index), y: sensorValue.value))
                }
                self.lightData = dataArray
            }
        } catch {
            print(error)
        }
    }
}
