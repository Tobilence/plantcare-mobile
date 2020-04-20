//
//  TitledTextField.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 19.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import SwiftUI

struct TitledTextField : View {
    
    var title: String
    @Binding var text: String
    @State var titleOnTop = false

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text, onEditingChanged: userDidEdit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text(title)
                .font(.footnote)
                .italic()
                .padding(.leading, 5)
                .offset(y: evaluateTitleOnTop() ? -25 : 0)
                .animation(.easeInOut)
        }
        .padding()
    }
    
    func userDidEdit(started: Bool) {
        if started {
            self.titleOnTop = true
        } else {
            self.titleOnTop = false
        }
    }
    
    func evaluateTitleOnTop() -> Bool{
        if text != "" || titleOnTop {
            return true
        } else {
            return false
        }
    }
}
