//
//  ProfilePicture.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct ProfilePicture: View {
    
    @State private var showActionSheet = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @EnvironmentObject var userViewModel: UserViewModel
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Change Profile Picture"), buttons: [
            .default(Text("Take Picture"), action: takePicture),
            .default(Text("Import from Photos"), action: importFromPhotos),
            .default(Text("Delete Picture"), action: deletePicture),
            .destructive(Text("Cancel"))
        ])
    }
    
    var body: some View {
        ZStack {
            if userViewModel.uiImage != nil{
                Image(uiImage: userViewModel.uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(maxHeight: 200)
                    .padding()
            }
            else {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .padding()
                    .foregroundColor(Color.blue)
            }
            
            if userViewModel.editable {
                Image(systemName: "perspective")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 75)
                    .padding()
                    .opacity(0.5)
                    .blendMode(.multiply)
                    .onTapGesture {
                        self.showActionSheet.toggle()
                    }
                    .actionSheet(isPresented: $showActionSheet, content: {
                    self.actionSheet })
            }
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(isVisibile: self.$showImagePicker, image: self.$userViewModel.uiImage, sourceType: self.sourceType)
        }
    }
    
    private func takePicture() {
        self.showImagePicker = true
        self.sourceType = .camera
    }
    
    private func importFromPhotos() {
        self.showImagePicker = true
        self.sourceType = .photoLibrary
    }
    
    private func deletePicture() {
        if userViewModel.uiImage != nil {
            self.userViewModel.uiImage = nil
        }
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture()
    }
}
