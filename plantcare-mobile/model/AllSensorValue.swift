//
//  AllSensorValue.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 25.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct AllSensorValue: Decodable {
    
    var light: SensorValue
    var groundHumidity: SensorValue
    var airPressure: SensorValue
    var temperature: SensorValue
}
