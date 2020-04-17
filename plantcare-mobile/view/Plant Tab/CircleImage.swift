//
//  CircleImage.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    
    @State var imageName: String
    @State var shadowRadius:CGFloat
    
    var body: some View {
        Image(imageName)
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
            .shadow(radius: shadowRadius)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(imageName: "rose", shadowRadius: 2)
    }
}
