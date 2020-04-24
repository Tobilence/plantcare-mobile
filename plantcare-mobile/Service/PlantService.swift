//
//  PlantRequest.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

class PlantService : AbstractClient<Plant>{
    
    init() {
        super.init(urlEnding: "/plants")
    }
}
