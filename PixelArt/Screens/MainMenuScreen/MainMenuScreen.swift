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
    2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
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

let dummyPictureModel: PixelPictureDataModel = PixelPictureDataModel(id: "asdid", name: "Dummy Picture", width: 16, height: 16, palette: dummyPalette, pixelData: dummyData)

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
                Text("Other Screen")
            } label: {
                Text("Go To Other Screen")
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
        loggedUserVM.logOut()
        ContentView()
    }
}
