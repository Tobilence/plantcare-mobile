//
//  ProfileView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @State private var loading = true
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass
        
    var body: some View {
        ZStack {
            if verticalSizeClass == .compact {
                HStack {
                    ProfilePicture()
                        .environmentObject(userViewModel)
                    Spacer()
                    VStack {
                        displayProfileContent()
                        editButton()
                    }
                }
                .padding()
            } else {
                VStack {
                    Spacer()
                    Group {
                        ProfilePicture()
                            .environmentObject(userViewModel)
                        displayProfileContent()
                    }
                    Spacer()
                    Spacer()
                    editButton()
                    Spacer()
                    
                }
                .padding([.leading, .trailing])
            }
        }
    }
    
    ///displays the content of the profile
    ///returns text fields and image if editable and data is received
    ///returns texts and image if not editable and data is received
    ///returns activity indicator if no data is received yet
    func displayProfileContent() -> some View {
        return ZStack {
            //checks if the data is obtained yet
            if userViewModel.id != -1 {
                if userViewModel.editable {
                    EditableProfile()
                        .environmentObject(userViewModel)
                        .frame(width: 250, height: 250)
                } else {
                    NonEditableProfile()
                        .environmentObject(userViewModel)
                        .frame(width: 250, height: 250)
                }
            } else {
                //shows that the data is still loading
                ActivityIndicator(shouldAnimate: self.$loading)
            }
        }
    }
    
    ///displays the edit Button
    private func editButton() -> some View {
        Button(action: {
            self.userViewModel.editable.toggle()
            if !self.userViewModel.editable && self.userViewModel.changesMade{
                print("data sent")
                self.userViewModel.sendDataToServer()
            }
        }) {
            Text(self.userViewModel.editable ? "Save" : "Edit")
                .foregroundColor(Color.white)
                .padding([.trailing, .leading])
                .font(.title)
        }
        .frame(minWidth: 125, minHeight: 50)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

