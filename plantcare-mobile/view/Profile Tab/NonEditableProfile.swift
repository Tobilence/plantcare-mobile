//
//  NonEditableProfile.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct NonEditableProfile: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack (spacing: 50) {
            
            VStack (spacing: 15) {
                Text(userViewModel.email)
                Text(userViewModel.firstName)
                Text(userViewModel.lastName)
            }
            .frame(maxHeight: 300)
        }
    }
}

struct NonEditableProfile_Previews: PreviewProvider {
    static var previews: some View {
        NonEditableProfile()
    }
}
