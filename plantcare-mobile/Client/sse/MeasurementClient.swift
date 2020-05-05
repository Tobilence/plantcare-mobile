//
//  LightSensorClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 25.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import IKEventSource

struct MeasurementClient: SensorClient {
    
    var eventSource: EventSource
    var eventName: String
    
    init(measurementName: String, id: Int) {
        guard let url = URL(string: "https://plantcare.msgis.net/api/data/\(measurementName)/sse?plantBoxId=\(id)&days=14") else {
            print("could not create \(measurementName) sse url")
            fatalError()
        }
        
        self.eventSource = EventSource(url: url)
        self.eventName = measurementName
    }
}
