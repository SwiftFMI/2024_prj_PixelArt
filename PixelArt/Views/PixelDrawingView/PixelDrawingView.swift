//
//  PixelDrawingView.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 8.01.25.
//

import SwiftUI

struct PixelDrawingView: View {
    var currentViewPixelPicture: PixelPictureDataModel
    var pixelCountX: CGFloat
    var pixelCountY: CGFloat
    let pixelSize: CGFloat = 16
   
    @Environment(\.dismiss) private var dismiss
    @State private var isVictory = false
    @Binding var currentSelectedColor: PaletteColor
    
    @State private var boolArr: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 16), count: 16)
    @State private var shouldPan = true
    @State private var hapticTrigger = false
    @GestureState private var location: CGPoint = .zero
    
    init(picture: PixelPictureDataModel, currentColor: Binding<PaletteColor>) {
        self.currentViewPixelPicture = picture
        pixelCountX = CGFloat(currentViewPixelPicture.width)
        pixelCountY = CGFloat(currentViewPixelPicture.height)
        self._currentSelectedColor = currentColor
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
                            PixelSquare(squareSize: pixelSize, isColored: $boolArr[i-1][j-1], colorNum: currentViewPixelPicture.getDataAt(x: i-1, y: j-1), currentColor: $currentSelectedColor)
                                .gesture(fullGesture)
                                .simultaneousGesture(TapGesture()
                                    .onEnded { _ in
                                        if (currentViewPixelPicture.getDataAt(x: i-1, y: j-1) == currentSelectedColor.id) {
                                            boolArr[i-1][j-1] = -1
                                            self.victoryCheck()
                                        } else if (self.boolArr[i-1][j-1] != -1){
                                            boolArr[i-1][j-1] += 1
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
                       self.boolArr[indexI-1][indexJ-1] = -1
                       self.victoryCheck()
                   } else if (self.boolArr[indexI-1][indexJ-1] != -1){
                       self.boolArr[indexI-1][indexJ-1] += 1
                   }
               }
           }
           return AnyView(Rectangle().fill(Color.clear))
       }
    }
    func victoryCheck() {
        var flag = true
        for row in boolArr {
            for item in row {
                if item != -1 {flag = false}
            }
        }
        if(flag) {
            isVictory = true
        }
    }
}

