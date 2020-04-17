//
//  TabView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    
    let plantRequest:PlantService = PlantService()
    
    var body: some View {
        TabView {
            PlantBoxListView()
                .tabItem {
                    tabViewItem(text: "Plant Boxes", iconName: "archivebox.fill")
                }
                .tag(0)
            
            PlantListView()
                .tabItem {
                    tabViewItem(text: "Plants", iconName: "circle.grid.hex")
                }
                .tag(1)
            
            ProfileView()
                .environmentObject(UserViewModel())
                .tabItem {
                    tabViewItem(text: "Profile", iconName: "person.fill")
                }
                .tag(2)
        }
    }
    
    private func tabViewItem(text: String, iconName: String) -> some View {
        return VStack {
            Image(systemName: iconName)
            Text(text)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
