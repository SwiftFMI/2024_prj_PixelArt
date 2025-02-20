//
//  PixelDrawingView.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 8.01.25.
//

import SwiftUI

struct PixelDrawingView: View {
    var currentViewPixelPicture: PixelPictureData
    var pixelCountX: CGFloat
    var pixelCountY: CGFloat
    let pixelSize: CGFloat = 16
   
    @Environment(\.dismiss) private var dismiss
    @State private var isVictory = false
    @Binding var currentSelectedColor: PaletteColor
    
    @Binding private var memArr: [Int]
    @State private var shouldPan = true
    @State private var hapticTrigger = false
    @GestureState private var location: CGPoint = .zero
    
    init(picture: PixelPictureData, currentColor: Binding<PaletteColor>, memArr: Binding<[Int]>) {
        self.currentViewPixelPicture = picture
        pixelCountX = CGFloat(currentViewPixelPicture.width)
        pixelCountY = CGFloat(currentViewPixelPicture.height)
        self._currentSelectedColor = currentColor
        self._memArr = memArr
    }
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.3)
            .onEnded { _ in
                shouldPan = false
                hapticTrigger = !hapticTrigger
            }
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .updating($location) { (value, state, transaction) in
                state = value.location
            }
            .onEnded { _ in
                shouldPan = true
                hapticTrigger = !hapticTrigger
            }
        let fullGesture = longPressGesture.sequenced(before: dragGesture)
        
        ZoomPanView(expectedWidth: pixelCountX * (pixelSize) + 50, expectedHeight: pixelCountY * (pixelSize) + 50, shouldBePanning: $shouldPan) {
            Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(1...Int(pixelCountY), id: \.self) { i in
                    GridRow {
                        ForEach(1...Int(pixelCountX), id: \.self) { j in
                            PixelSquare(squareSize: pixelSize, isColored: $memArr[(i-1) * Int(pixelCountY) + j-1], colorNum: currentViewPixelPicture.getDataAt(x: i-1, y: j-1), palette: currentViewPixelPicture.palette, currentColor: $currentSelectedColor)
                                .gesture(fullGesture)
                                .simultaneousGesture(TapGesture()
                                    .onEnded { _ in
                                        if (currentViewPixelPicture.getDataAt(x: i-1, y: j-1) == currentSelectedColor.id) {
                                            self.memArr[(i-1) * Int(pixelCountY) + j-1] = -currentSelectedColor.id
                                            self.victoryCheck()
                                        } else if (self.memArr[(i-1) * Int(pixelCountY) + j-1] >= 0){
                                            self.memArr[(i-1) * Int(pixelCountY) + j-1] = currentSelectedColor.id
                                        }
                                    }
                                )
                                .overlay(self.rectReader(indexI: i, indexJ: j))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sensoryFeedback(.impact(weight: .heavy, intensity: 5), trigger: hapticTrigger)
        }.alert("Congratulations !!!\nYou completed the Draw!", isPresented: $isVictory) {
            Button("Return to Menu", role: .cancel) {dismiss()}
            Button("Admire") {}
        }
    }
    
    
    
    func rectReader(indexI: Int, indexJ: Int) -> some View {
       return GeometryReader { (geometry) -> AnyView in
           if geometry.frame(in: .global).contains(self.location) && !shouldPan && self.location != .zero {
               DispatchQueue.main.async {
                   if (currentViewPixelPicture.getDataAt(x: indexI-1, y: indexJ-1) == currentSelectedColor.id) {
                       self.memArr[(indexI-1) * Int(pixelCountY) + indexJ-1] = -currentSelectedColor.id
                       self.victoryCheck()
                   } else if (self.memArr[(indexI-1) * Int(pixelCountY) + indexJ-1] >= 0){
                       self.memArr[(indexI-1) * Int(pixelCountY) + indexJ-1] = currentSelectedColor.id
                   }
               }
           }
           return AnyView(Rectangle().fill(Color.clear))
       }
    }
    
    
    func victoryCheck() {
        var flag = true
        for item in memArr {
            if item >= 0 {flag = false}
        }
        if(flag) {
            isVictory = true
        }
    }
    
}

