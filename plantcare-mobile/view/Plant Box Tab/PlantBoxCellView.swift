//
//  PlantBoxCellView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 15.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct PlantBoxCellView: View {
    
    @EnvironmentObject var plantBoxViewModel: PlantBoxViewModel
    
    var body: some View {
        VStack {
            if plantBoxViewModel.uiImage != nil {
                Image(uiImage: plantBoxViewModel.uiImage!)
                    .padding()
                    .cornerRadius(5)
            } else {
                Image("plantbox-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
            }
            Text(plantBoxViewModel.name)
                .font(.title)
        }
        .listRowBackground(Color.gray)
    }
}

struct PlantBoxCellView_Previews: PreviewProvider {
    static var previews: some View {
        PlantBoxCellView()
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
