//
//  FreeDrawingPixelView.swift
//  PixelArt
//
//  Created by Ivaylo Atanasov on 20.02.25.
//

import SwiftUI

struct FreeDrawingPixelView: View {
    @State private var backCol = Color(uiColor: UIColor(named: "PixelLightGray")!)
    
    @Binding private var currentColor: Int
    private let palette: [PaletteColor]
    private var squareSize: CGFloat
    
    init(squareSize: CGFloat, palette: [PaletteColor], currentColor: Binding<Int>) {
        self.squareSize = squareSize
        self.palette = palette
        self._currentColor = currentColor
    }
    
    var squareBackView: some View {
        Rectangle()
            .fill(currentColor > 0 && currentColor <= palette.count ? Color(uiColor: UIColor(hex: palette[currentColor-1].color) ?? .white) : .white)
    }
    
    var body: some View {
        Text("")
            .frame(width: squareSize, height: squareSize)
            .foregroundStyle(Color.black)
            .font(Font.system(size: 10.0))
            .background(squareBackView)
            .onChange(of: currentColor) {
                withAnimation(.easeIn(duration: 0.1)) {
                    self.backCol = Color.white
                }
                withAnimation(.easeIn(duration: 0.1).delay(0.1)) {
                    self.backCol = Color(uiColor: UIColor(hex: palette[currentColor-1].color) ?? .white)
                }
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: currentColor > 0)
    }
}
