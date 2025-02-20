//
//  PixelPictureScreen.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 16.02.25.
//

import SwiftUI



struct PixelPictureScreen: View {
    let currentScreenPixelPicture: PixelPictureData
    @State var currentSelectedColor: PaletteColor = PaletteColor(id: 1, color: .red)

    init(picture: PixelPictureData) {
        self.currentScreenPixelPicture = picture
        self.currentSelectedColor = PaletteColor(id: 1, color: .red)
        self.currentSelectedColor = picture.palette.first ?? PaletteColor(id: 1, color: .red)
        
    }
    var body: some View {
        ZStack {
            VStack {
                PixelDrawingView(picture: self.currentScreenPixelPicture, currentColor: $currentSelectedColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            VStack {
                PaletteView(palette: currentScreenPixelPicture.palette, currentColor: $currentSelectedColor)
                    //.border(Color.green)
                Spacer()
            }
        }
        .navigationTitle(self.currentScreenPixelPicture.name)
    }
}
