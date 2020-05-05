//
//  LatestDataSensorClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 25.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import IKEventSource

struct LatestDataSensorClient: SensorClient {
    
    var eventSource: EventSource
    var eventName: String
    
    init(id: Int) {
        guard let url = URL(string: "https://plantcare.msgis.net/api/data/sse/latest?plantBoxId=\(id)") else {
            print("could not create latestDataUrl")
            fatalError()
        }
        self.eventSource = EventSource(url: url)
        self.eventName = "sensorData"
    }
}
