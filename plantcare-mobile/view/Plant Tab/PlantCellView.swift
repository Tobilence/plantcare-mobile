//
//  PlantCellView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct PlantCellView: View {
    
    @EnvironmentObject var plantViewModel: PlantViewModel
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        HStack {
            Image(base64String: plantViewModel.picture)
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
            .frame(width: width, height: height)
            Text(plantViewModel.trivialName)
                .font(.title)
                .fontWeight(.light)
            Spacer()
        }
    }
}

struct PlantCellView_Previews: PreviewProvider {
    static var previews: some View {
        PlantCellView(width: 100, height: 80)
         .previewLayout(.fixed(width: 300, height: 90))
    }
}
