//
//  SensorClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import ReactiveSSE

struct SensorClient {
    
    func subscribeToLight() {
        let sse = ReactiveSSE(urlRequest: URLRequest(url: URL(string: "https://plantcare.msgis.net/api/data/latest?plantBoxId=29")!))
    }
}
