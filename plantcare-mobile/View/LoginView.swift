//
//  LoginView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username:String = ""
    @State private var password:String = ""
    @State private var isLoggedIn = false
    @State private var isLoading = false
    @State private var loginAttempts: Int = 0
    @ObservedObject var loginViewRouter: LoginViewRouter = LoginViewRouter()
    @ObservedObject var sensorViewModel = SensorViewModel()
    
    var body: some View {

        ZStack {
            if isLoggedIn && loginViewRouter.plantListLoaded && loginViewRouter.plantBoxListLoaded {
                MainTabView()
                    .transition(.opacity)
                    .environmentObject(sensorViewModel)
                    .environmentObject(loginViewRouter.plantList!)
                    .environmentObject(loginViewRouter.plantBoxList!)
            }
            else {
                ZStack {
                    VStack {
                        Spacer()
                        Text("Plant-Care")
                            .font(.custom("Avenir-Light", size: 50))
                            .foregroundColor(.black)
                            .padding(.bottom, 50)
                        VStack {
                            TextField("Username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .modifier(Shake(animatableData: CGFloat(loginAttempts)))
                        .padding(.bottom, 50)
                        Button(action: {
                            if self.username == "User" && self.password == "user" {
                                withAnimation {
                                    self.isLoading = true
                                    self.isLoggedIn = true
                                    self.loginViewRouter.startLoading()
                                }
                            } else {
                                withAnimation {
                                    self.loginAttempts += 1
                                    self.simpleHaptic()
                                }
                            }
                        }) {
                            Text("Log In")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        if isLoading {
                            Text("loading")
                        }
                        Spacer()
                        Spacer()
                    }
                    .padding([.trailing, .leading], 65)
                    .background(
                        Image("login-background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
//                    .brightness(isLoading ? -0.3 : 0)
                    .edgesIgnoringSafeArea(.all)
                    
                    if isLoading {
                        GeometryReader { _ in
                            CustomActivityIndicator()
                        }
                        .background(Color.black.opacity(0.45))
                        .edgesIgnoringSafeArea(.all)
                    }
                }
            }
        }
    }
    
    func simpleHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
