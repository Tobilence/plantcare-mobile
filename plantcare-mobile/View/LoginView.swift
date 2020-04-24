//
//  LoginView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var username:String = "Username"
    
    var body: some View {
        VStack {
            Spacer()
            Text("Plant-Care")
            Spacer()
        }
        .background(
            Image("login-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
