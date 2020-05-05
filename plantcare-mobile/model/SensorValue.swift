//
//  SensorValue.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 22.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct SensorValue: Decodable{
    
    var timestamp: String
    var hardwareId: String
    var unit: String
    var value: Double
}
