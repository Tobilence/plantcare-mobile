//
//  AddPlantCellView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 18.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct AddPlantCellView: View {
    
    @EnvironmentObject var plantBox: PlantBoxViewModel
    @State var showPicker: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text("Add Plant")
            Spacer()
            Image(systemName: "plus")
                .foregroundColor(Color.black)
                .padding()
            Spacer()
        }.onTapGesture(perform: {
            self.showPicker = true
        })
    }
}

struct AddPlantCellView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantCellView(showPicker: false)
            .previewLayout(.fixed(width: 200, height: 60))
    }
}
