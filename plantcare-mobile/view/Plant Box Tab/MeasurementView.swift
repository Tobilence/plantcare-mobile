//
//  MeasurementView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 17.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct MeasurementView: View {
    
    var measurementName: String
    var unit: String
    @State var value: Double
    
    var body: some View {
        VStack {
            HStack (alignment: .lastTextBaseline) {
                Text(String(value))
                    .font(.largeTitle)
                    .foregroundColor(Color.green)
                
                Text(unit)
                    .font(.body)
                    .foregroundColor(Color.green)
            }
            Text(measurementName)
                .fontWeight(.light)
                .font(.footnote)
        }
    }
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView(measurementName: "Temerature", unit: "Degree Celsius", value: 22.5)
    }
}
