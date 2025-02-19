//
//  PixelArtApp.swift
//  PixelArtApp
//
//  Created by Ivaylo Atanasov on 8.01.25.
//

import SwiftUI
import Firebase

@main
struct PixelArtApp: App {
    @StateObject var loggedUserVM = LoggedUserViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(loggedUserVM)
    }
}
