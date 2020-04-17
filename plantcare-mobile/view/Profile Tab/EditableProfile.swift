//
//  EditableProfile.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct EditableProfile: View {
    
    @EnvironmentObject var userViewModel:UserViewModel
    
    var body: some View {
        VStack (spacing: 50) {
            VStack (spacing: 15) {
                TextField("Email", text: $userViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("First Name", text: $userViewModel.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Last Name", text: $userViewModel.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .frame(maxHeight: 300)
        }
    }
}

struct EditableProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditableProfile()
    }
}
