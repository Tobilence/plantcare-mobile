//
//  LoginRoutingView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 29.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct LoginRoutingView: View {
    
    @State private var isLoggedIn = false
    
    var body: some View {
        ZStack {
            if isLoggedIn {
                MainTabView()
            } else {
                LoginView(logIn: isLoggedIn)
            }
        }
    }
}

struct LoginRoutingView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRoutingView()
    }
}
