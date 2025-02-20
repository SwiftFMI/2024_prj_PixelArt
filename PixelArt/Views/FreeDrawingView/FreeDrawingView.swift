//
//  FreeDrawingView.swift
//  PixelArt
//
//  Created by Ivaylo Atanasov on 20.02.25.
//

import SwiftUI

struct FreeDrawingView: View {
    var pixelCountX: CGFloat
    var pixelCountY: CGFloat
    let pixelSize: CGFloat = 16
    
    private let palette: [PaletteColor]
    
    @Environment(\.dismiss) private var dismiss
    @Binding var currentSelectedColor: PaletteColor
    @Binding var drawingBoard: [Int]
    
    @State private var shouldPan = true
    @State private var hapticTrigger = false
    @GestureState private var location: CGPoint = .zero
    
    init(width: Int, height: Int, palette: [PaletteColor], currentColor: Binding<PaletteColor>, drawingBoard: Binding<[Int]>) {
        pixelCountX = CGFloat(width)
        pixelCountY = CGFloat(height)
        self.palette = palette
        self._drawingBoard = drawingBoard
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
                            FreeDrawingPixelView(squareSize: self.pixelSize, palette: self.palette, currentColor: $drawingBoard[(i-1) * Int(pixelCountY) + j-1])
                                .gesture(fullGesture)
                                .simultaneousGesture(TapGesture()
                                    .onEnded { _ in
                                        drawingBoard[(i-1) * Int(pixelCountY) + j-1] = currentSelectedColor.id
                                    }
                                )
                                .overlay(self.rectReader(indexI: i, indexJ: j))
                        }
                    }
                }
            }
            .border(Color.black, width: 1)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sensoryFeedback(.impact(weight: .heavy, intensity: 5), trigger: hapticTrigger)
        }
//        .alert("Congratulations !!!\nYou completed the Draw!", isPresented: $isVictory) {
//            Button("Return to Menu", role: .cancel) {dismiss()}
//            Button("Admire") {}
//        }
    }
    
    
    
    func rectReader(indexI: Int, indexJ: Int) -> some View {
       return GeometryReader { (geometry) -> AnyView in
           if geometry.frame(in: .global).contains(self.location) && !shouldPan && self.location != .zero {
               DispatchQueue.main.async {
                   drawingBoard[(indexI-1) * Int(pixelCountY) + indexJ-1] = currentSelectedColor.id
               }
           }
           return AnyView(Rectangle().fill(Color.clear))
       }
    }
    
}

