//
//  FreeDrawConfirmationScreen.swift
//  PixelArt
//
//  Created by Ivaylo Atanasov on 20.02.25.
//

import SwiftUI
import FirebaseAuth

//let id: String
//let name: String
//let createdBy: String
//let createdOn: Date
//let width: Int
//let height: Int
//let palette: [PaletteColor]
//let pixelData: [Int]
//let pixelMemory: [Int]

struct FreeDrawConfirmationScreen: View {
    @EnvironmentObject var loggedUserVM: LoggedUserViewModel
    @EnvironmentObject var picturesVM: PixelArtsViewModel
    
    private let id: String = PixelPictureData.generateFirestoreID()
    @State private var name: String = ""
    @State private var createdBy: String = ""
    private let createdOn: Date = Date.now
    private let width: Int
    private let height: Int
    private let palette: [PaletteColor]
    private let pixelData: [Int]
    private let pixelMemory: [Int]
    
    @Environment(\.dismiss) private var dismiss
    
    init(width: Int, height: Int, palette: [PaletteColor], pixelData: [Int]) {
        self.width = width
        self.height = height
        self.palette = palette
        self.pixelData = pixelData
        self.pixelMemory = [Int](repeating: 0, count: width * height)
    }
    
    var body: some View {
        VStack {
            Text("Please name your creation:")
            TextField("Drawing name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            Button {
                let data = PixelPictureData(id: self.id, name: self.name, createdBy: self.createdBy, createdOn: self.createdOn, width: self.width, height: self.height, palette: self.palette, pixelData: self.pixelData, pixelMemory: self.pixelMemory)
                self.picturesVM.savePicture(picture: data)
                dismiss()
            } label: {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 40)
        .onAppear {
            Task {
                await fetchUserID()
            }
        }
    }
    
    private func fetchUserID() async {
        if let currentUser = loggedUserVM.user {
            self.createdBy = currentUser.id
        } else {
            self.createdBy = "Noone"
        }
    }
}

