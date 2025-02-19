//
//  ContentView.swift
//  PixelArt
//
//  Created by vnc003 on 16.02.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loggedUserVM: LoggedUserViewModel
    
    var body: some View {
        VStack {
            if loggedUserVM.session != nil {
                NavigationStack {
                    MainMenuScreen()
                }
            } else {
                MainUnregisteredScreen()
            }
        }
    }
}
