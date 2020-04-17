//
//  UIImageExtension.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension Image {
    
    init(base64String: String) {
        let imageData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        let uiImage = UIImage(data: imageData)!
        self.init(uiImage: uiImage)
    }
}

extension UIImage {
    
    static func fromBase64String(_ base64String: String) -> UIImage? {
        let imageData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData) ?? UIImage(systemName: "person.circle.fill")
    }
    
    func convertToBase64String() -> String {
        let imageData:NSData = self.jpegData(compressionQuality: 0)! as NSData
           let strBase64 = imageData.base64EncodedString()
           return strBase64
    }
}
