//
//  PaletteSingeColorView.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 17.02.25.
//

import SwiftUI

struct PaletteSingeColorView: View {
    @Binding var selectedColor: PaletteColor
    
    let color: PaletteColor
    let contrastColor: UIColor
    
    init(color: PaletteColor, selectedColor: Binding<PaletteColor>) {
        self.color = color
        if let col = UIColor(hex: color.color) {
            self.contrastColor = col.contrastColor()
        } else {
            self.contrastColor = .white
        }
        self._selectedColor = selectedColor
    }
    
    var body: some View {
        ZStack {
            Text(String(color.id))
                .frame(width: 75.0, height: 75.0)
                .border(Color(uiColor: contrastColor), width: selectedColor.id == color.id ? 5 : 0)
                .font(.system(size: 28))
                .foregroundColor(Color(uiColor: contrastColor))
                .background(Color(uiColor: UIColor(hex: color.color)!))
        }
    }
    
    
}

extension UIColor {
    func contrastColor() -> UIColor {
        let luminance = (0.29 * self.rgba.red + 0.58 * self.rgba.green + 0.11 * self.rgba.blue)
        if (luminance > 0.5) {
            return .black
        } else {
            return .white
        }
    }
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
