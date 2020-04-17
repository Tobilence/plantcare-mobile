//
//  WebError.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 15.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

enum WebError: Error {
    case unableToDecodeData
    case responseProblem
    case unableToEncodeData
    case unableToCreateUrl
    case unableToObtainData
}
