//
//  PlantDetailView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct PlantDetailView: View {
    
    @EnvironmentObject var plantViewModel:PlantViewModel
    
    var body: some View {
        ScrollView (.vertical){
            Image(base64String: plantViewModel.picture)
                .resizable()
                .cornerRadius(10)
                .aspectRatio(contentMode: .fit)
                .padding()
            
            VStack (spacing: 10) {
                Text("Description")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(plantViewModel.description)
            }
            .padding()
                
            .navigationBarTitle(plantViewModel.trivialName)
        }
    }
}

struct PlantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlantDetailView()
        }
    }
}
