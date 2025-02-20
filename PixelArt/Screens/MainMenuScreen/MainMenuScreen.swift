//
//  MainMenuScreen.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 17.02.25.
//

import SwiftUI

let dummyPalette = [
    PaletteColor(id: 1, color: UIColor.red),
    PaletteColor(id: 2, color: UIColor.yellow),
    PaletteColor(id: 3, color: UIColor.black),
    PaletteColor(id: 4, color: UIColor.blue),
    PaletteColor(id: 5, color: UIColor.green),
    PaletteColor(id: 6, color: UIColor.purple)
]

let dummyData = [
    6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2
]

let dummyMemory = [
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, -2,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 3, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    -1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
]

let dummyPictureModel: PixelPictureData = PixelPictureData(id: "id", name: "asdfgh", createdBy: "ivailos", createdOn: Date.now, width: 16, height: 16, palette: dummyPalette, pixelData: dummyData, pixelMemory: dummyMemory)

struct MainMenuScreen: View {
    @EnvironmentObject var loggedUserVM: LoggedUserViewModel
    @State private var isLoading: Bool = false
    
    var body: some View {
        
        VStack {
            NavigationLink {
                PixelPictureScreen(picture: dummyPictureModel)
            } label: {
                Text("Start Dummy Game")
            }
            Spacer().frame(height: 20)
            NavigationLink {
                FreeDrawScreen(width: 16, height: 16, completionHandler: { pixelPictureData in
                    print(pixelPictureData)
                })
            } label: {
                Text("Free Draw Screen")
            }
            Button(action: logoutUser) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Log out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)
            .disabled(isLoading)
            
        }
        .navigationTitle("PixelDraw")
    }
    
    private func logoutUser() {
        isLoading = true
        Task {
            try await loggedUserVM.logOut()
            isLoading = false
            ContentView()
        }
    }
}
