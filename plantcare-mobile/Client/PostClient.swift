
//
//  PostClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

protocol ReadWriteClient: ReadClient {
    
    associatedtype EncodableModel: Encodable
    
}
