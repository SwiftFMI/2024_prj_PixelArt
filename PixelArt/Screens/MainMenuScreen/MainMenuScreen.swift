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
    @EnvironmentObject var picturesVM: PixelArtsViewModel
    @State private var isLoading: Bool = false
    @State private var selectedSize: String = "8x8"
    @State private var navigateToFreeDraw = false
    
    private let sizeOptions = ["2x2", "4x4", "8x8", "16x16", "32x32"]
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: PixelArtsGridView()) {
                    Text("Colour a pixel art!")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                Spacer().frame(height: 20)
                
                Menu {
                    ForEach(sizeOptions, id: \.self) { option in
                        Button(action: {
                            selectedSize = option
                            navigateToFreeDraw = true
                        }) {
                            Text(option)
                        }
                    }
                } label: {
                    Text("Create your own pixel art")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                Spacer().frame(height: 20)
                
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
            .background(
                NavigationLink(
                    destination: FreeDrawScreen(
                        width: getWidth(from: selectedSize),
                        height: getHeight(from: selectedSize)
                    ),
                    isActive: $navigateToFreeDraw
                ) {
                    EmptyView()
                }
                    .hidden()
            )
        }
    }
    
    private func getWidth(from option: String) -> Int {
        return Int(option.components(separatedBy: "x").first ?? "8") ?? 8
    }
    
    private func getHeight(from option: String) -> Int {
        return Int(option.components(separatedBy: "x").last ?? "8") ?? 8
    }
    
    private func logoutUser() {
        loggedUserVM.logOut()
    }
}

