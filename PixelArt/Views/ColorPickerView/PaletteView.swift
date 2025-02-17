//
//  PixelColorPickerView.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 17.02.25.
//

import SwiftUI

struct PaletteView: View {
    
    let palette: [PaletteColor]
    @Binding var currentColor: PaletteColor
    
    init(palette: [PaletteColor], currentColor: Binding<PaletteColor>) {
        self.palette = palette
        self._currentColor = currentColor
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(palette, id: \.self) { palCol in
                        Button {
                            currentColor = palCol
                        } label: {
                            Text(String(palCol.id))
                                .padding(.all, 8)
                                .border(Color(palCol.color), width: 4)
                                .foregroundStyle(Color.black)
                                .font(Font.system(size: 20.0))
                                .presentationCornerRadius(15)
                                .padding(.all, 8)
                        }
                    }
                }
            }
            Color(currentColor.color)
                .frame(height: 20.0)
        }
        .background(Color(UIColor(named: "PixelLightGray")!))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
        .padding(.all, 16)
    }
}
