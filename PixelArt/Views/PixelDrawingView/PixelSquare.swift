//
//  PixelSquare.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 8.01.25.
//


import SwiftUI

struct PixelSquare: View {
    @State private var backCol = Color(uiColor: UIColor(named: "PixelLightGray")!)
    @State private var shouldPan = false
    @State private var text: String
    @Binding private var isColored: Int
    @Binding var currentSelectedColor: PaletteColor
    private var squareSize: CGFloat
    
    init(squareSize: CGFloat, isColored: Binding<Int>, colorNum: Int, currentColor: Binding<PaletteColor>) {
        self.squareSize = squareSize
        self._isColored = isColored
        self.text = .init(String(colorNum))
        self._currentSelectedColor = currentColor
    }
    
    var squareBackView: some View {
        Rectangle()
            .fill(backCol)
            //.border(isColored < 0 ? backCol : Color.white, width: 1)
    }
    
    var body: some View {
        Text(text)
            .frame(width: squareSize, height: squareSize)
            .foregroundStyle(Color.black)
            .font(Font.system(size: 10.0))
            .background(squareBackView)
            .onChange(of: isColored) {
                if(isColored < 0) {
                    withAnimation(.easeIn(duration: 0.1)) {
                        self.backCol = Color.white
                        self.text = ""
                    }
                    withAnimation(.easeIn(duration: 0.1).delay(0.1)) {
                        self.backCol = Color(currentSelectedColor.color)
                    }
                } else if(self.text != "") {
                    withAnimation(.easeIn(duration: 0.1)) {
                        self.backCol = Color.white
                    }
                    withAnimation(.easeIn(duration: 0.1).delay(0.1)) {
                        self.backCol = Color(currentSelectedColor.color).opacity(0.5)
                    }
                }
            }
            //.sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: isColored < 0)
    }
}
