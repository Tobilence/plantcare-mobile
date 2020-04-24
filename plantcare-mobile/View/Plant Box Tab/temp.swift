//
//  temp.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 20.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
   var colors = ["Red", "Green", "Blue", "Tartan"]
   @State private var selectedColor = 0

   var body: some View {
      VStack {
         Picker(selection: $selectedColor, label: Text("Please choose a color")) {
            ForEach(0 ..< colors.count) {
               Text(self.colors[$0])
            }
         }
         Text("You selected: \(colors[selectedColor])")
      }
   }
}

struct temp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
