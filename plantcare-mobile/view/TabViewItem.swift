//
//  TabViewItem.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct TabViewItem: View {
    @State var text:String
    @State var iconName:String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
            Text(text)
        }
    }
}

struct TabViewItem_Previews: PreviewProvider {
    static var previews: some View {
        TabViewItem(text: "Plant Box", iconName: "archivebox.fill")
    }
}
