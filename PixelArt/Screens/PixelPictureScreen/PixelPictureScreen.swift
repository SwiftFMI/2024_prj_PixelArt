//
//  PixelPictureScreen.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 16.02.25.
//

import SwiftUI



struct PixelPictureScreen: View {
    let currentScreenPixelPicture: PixelPictureData
    @State var memoryArr: [Int]
    @EnvironmentObject private var loggedUserVM: LoggedUserViewModel
    @State var currentSelectedColor: PaletteColor = PaletteColor(id: 1, color: .red)
    @Environment(\.dismiss) private var dismiss

    init(picture: PixelPictureData) {
        self.currentScreenPixelPicture = picture
        self._memoryArr = State(initialValue: currentScreenPixelPicture.pixelMemory)
        self.currentSelectedColor = PaletteColor(id: 1, color: .red)
        self.currentSelectedColor = picture.palette.first ?? PaletteColor(id: 1, color: .red)
    }
    var body: some View {
        ZStack {
            VStack {
                PixelDrawingView(picture: self.currentScreenPixelPicture, currentColor: $currentSelectedColor, memArr: $memoryArr)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            VStack {
                PaletteView(palette: currentScreenPixelPicture.palette, currentColor: $currentSelectedColor)
                Spacer()
            }
        }
        .navigationTitle(self.currentScreenPixelPicture.name)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    var backButton : some View {
        Button {
            let data = PixelPictureData(id: currentScreenPixelPicture.id, name: currentScreenPixelPicture.name, createdBy: currentScreenPixelPicture.createdBy, createdOn: currentScreenPixelPicture.createdOn, width: currentScreenPixelPicture.width, height: currentScreenPixelPicture.height, palette: currentScreenPixelPicture.palette, pixelData: currentScreenPixelPicture.pixelData, pixelMemory: memoryArr)
            self.loggedUserVM.savePictureForCurrentUser(picture: data)
            dismiss()
        } label: {
            HStack {
            Image("chevron.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text("Go back")
            }
        }
    }
}
