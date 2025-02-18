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
                HStack(spacing: 0) {
                    ForEach(palette, id: \.self) { palCol in
                        Button {
                            currentColor = palCol
                        } label: {
                            PaletteSingeColorView(color: palCol, selectedColor: $currentColor)
                        }
                    }
                }
            }
        }
    }
}
