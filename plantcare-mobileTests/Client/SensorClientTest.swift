//
//  SensorClientTest.swift
//  plantcare-mobileTests
//
//  Created by Tobias Furtlehner on 25.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import XCTest
@testable import plantcare_mobile

class SensorClientTest: XCTestCase {
    
    func testSpike() {
        let client = SensorClient()
        client.subscribeToLight { id, event, data in
            print(id)
            print(event)
            print(data)
        }
    }
}
