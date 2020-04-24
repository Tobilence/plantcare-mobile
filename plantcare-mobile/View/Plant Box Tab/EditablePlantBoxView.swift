//
//  EditablePlantBoxView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 18.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI

struct EditablePlantBoxView: View {
    
    @EnvironmentObject var plantBoxViewModel: PlantBoxViewModel
    @EnvironmentObject var plantListViewModel: PlantListViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var showActionSheet = false
    @State private var showHalfSheet = false
    @State private var showTrashCan = false
    @State private var selectedPlant: PlantViewModel? = nil
    @State private var plantIndexToAdd: Int = -1
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @GestureState private var dragOffset = CGSize.zero
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Change PlantBox Picture"), buttons: [
            .default(Text("Take Picture"), action: takePicture),
            .default(Text("Import from Photos"), action: importFromPhotos),
            .default(Text("Delete Picture"), action: deletePicture),
            .destructive(Text("Cancel"))
        ])
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                if plantBoxViewModel.uiImage == nil {
                    Image("plantbox-placeholder")
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight:300)
                        .onTapGesture {
                            self.showActionSheet = true
                        }
                        .actionSheet(isPresented: $showActionSheet, content: {
                        self.actionSheet })
                } else {
                    Image(uiImage: plantBoxViewModel.uiImage!)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight:300)
                        .onTapGesture {
                            self.showActionSheet = true
                        }
                        .actionSheet(isPresented: $showActionSheet, content: {
                        self.actionSheet })
                }

                TitledTextField(title: "Name", text: self.$plantBoxViewModel.name)
                    .frame(maxWidth: 280)
                
                //Plants
                VStack (spacing: 5) {
                    Text("Plants")
                        .font(.headline)
                        .fontWeight(.light)
                    HStack (spacing: 10) {
                        ForEach(plantBoxViewModel.plants) { plant in
                            Image(base64String: plant.picture)
                                .resizable()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .offset(x: self.selectedPlant == plant ? self.dragOffset.width : 0,
                                        y: self.selectedPlant == plant ? self.dragOffset.height : 0)
                                .animation(.easeInOut)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .gesture(
                                    DragGesture()
                                        .updating(self.$dragOffset, body: { (value, state, transaction) in
                                            if nil == self.selectedPlant {
                                                withAnimation {
                                                     self.selectedPlant = plant
                                                }
                                            }
                                            state = value.translation
                                        })
                                        .onEnded { value in
                                            withAnimation {
                                                self.selectedPlant = nil
                                            }
                                            if value.translation.height >= 140 && value.translation.width >= 70 {
                                                if let idx = self.plantBoxViewModel.plants.firstIndex(of: plant) {
                                                    self.plantBoxViewModel.plants.remove(at: idx)
                                                }
                                            }
                                        }
                                )
                        }
                        
                        //if only 3 plants - show add button
                        if self.plantBoxViewModel.plants.count <= 3 {
                            Button(action: {
                                self.showHalfSheet = true
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .padding()
                                    .foregroundColor(self.colorScheme == .light ? Color.black : Color.white)
                            }
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(self.colorScheme == .light ? Color.black : Color.white, style: StrokeStyle(lineWidth: 2, dash: [4]))
                            )
                            .frame(width: 70, height: 70)
                        }
                    }
                }
                Spacer()
                    .frame(minHeight: 100)
                HStack {
                    Spacer()
                    if selectedPlant != nil {
                        Button(action: {print("hello")}) {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.red)
                        }
                        .animation(.easeInOut)
                        .padding()
                    }
                }
            }.padding(.top, 50)
            
            HalfModalView(isShown: $showHalfSheet, modalHeight: 500) {
                VStack {
                    HStack {
                        Button(action: {
                            self.showHalfSheet = false
                        }) {
                            Text("Cancel")
                        }
                        Spacer()
                        Text("Choose a Plant")
                        Spacer()
                        Button(action: {
                            if self.plantIndexToAdd != -1 {
                                let plantToAdd = self.plantListViewModel.plants[self.plantIndexToAdd]
                                self.plantBoxViewModel.plants.append(PlantViewModel(plant: plantToAdd))
                            } else {
                                print("no plant selected in picker: index was -1")
                            }
                            
                            self.showHalfSheet = false
                        }) {
                            Text("Add Plant")
                        }
                    }
                    
                    Picker(selection: self.$plantIndexToAdd, label: EmptyView()) {
                        ForEach(0 ..< self.plantListViewModel.plants.count) {
                            Text(self.plantListViewModel.plants[$0].trivialName)
                        }
                    }
                    
                    Spacer()
                }
            }
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(isVisibile: self.$showImagePicker, image: self.$plantBoxViewModel.uiImage, sourceType: self.sourceType)
        }
    }
    
    func deletePlant(at offsets: IndexSet) {
        plantBoxViewModel.plants.remove(atOffsets: offsets)
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
        if plantBoxViewModel.uiImage != nil {
            self.plantBoxViewModel.uiImage = nil
        }
    }
}

struct EditablePlantBoxView_Previews: PreviewProvider {
    static var previews: some View {
        EditablePlantBoxView()
    }
}
