//
//  PixelArtApp.swift
//  PixelArtApp
//
//  Created by Ivaylo Atanasov on 8.01.25.
//

import SwiftUI

@main
struct PixelArtApp: App {
    @StateObject var loggedUserVM = LoggedUserViewModel()
    
    init() {
        Firebase.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if loggedUserVM.session != nil {
                MainMenuScreen()
            } else {
                MainUnregisteredScreen()
            }
        }
    }
}
