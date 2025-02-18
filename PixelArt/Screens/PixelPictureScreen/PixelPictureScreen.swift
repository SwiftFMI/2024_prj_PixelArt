//
//  PixelPictureScreen.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 16.02.25.
//

import SwiftUI



struct PixelPictureScreen: View {
    let currentScreenPixelPicture: PixelPictureDataModel
    @State var currentSelectedColor: PaletteColor

    init(picture: PixelPictureDataModel) {
        self.currentScreenPixelPicture = picture
        self.currentSelectedColor = picture.palette.first ?? PaletteColor(id: 1, color: UIColor.red)
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
