//
//  ImagePopUp.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct ImagePopUp: View {
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                
            }) {
                Image(systemName: "camera")
                    .foregroundColor(Color.white)
                
            }
            Button(action: {
                
            }) {
                Image(systemName: "photo")
                    .foregroundColor(Color.white)
                
            }
            Button(action: {
                
            }) {
                Image(systemName: "trash")
                    .foregroundColor(Color.white)
                
            }
        }
    .padding()
        .background(Color.black)
        .cornerRadius(5)
    }
}

struct ImagePopUp_Previews: PreviewProvider {
    static var previews: some View {
        ImagePopUp()
        .previewLayout(.fixed(width: 150, height: 50))
    }
}
