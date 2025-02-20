//
//  MainMenuScreen.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 17.02.25.
//

import SwiftUI

struct MainMenuScreen: View {
    @EnvironmentObject var loggedUserVM: LoggedUserViewModel
    @EnvironmentObject var picturesVM: PixelArtsViewModel
    @State private var isLoading: Bool = false
    
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
                        NavigationLink {
                            FreeDrawScreen(
                                width: getWidth(from: option),
                                height: getHeight(from: option)
                            )
                        } label: {
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

