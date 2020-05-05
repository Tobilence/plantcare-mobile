//
//  SensorClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import IKEventSource

protocol SensorClient {
    
    var eventSource: EventSource { get }
    var eventName: String { get }
}

extension SensorClient {
    
    func startListening(handler: @escaping (_ id: String?, _ event: String?, _ data: String?) -> Void) {
        eventSource.addEventListener(eventName, handler: handler)
        eventSource.connect()
    }
    
    func stopListening() {
        eventSource.disconnect()
    }
}
