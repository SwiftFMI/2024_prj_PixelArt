//
//  FreeDrawScreen.swift
//  PixelArt
//
//  Created by Ivaylo Atanasov on 19.02.25.
//

import SwiftUI



struct FreeDrawScreen: View {
        private var pixelCountX: Int
        private var pixelCountY: Int
        
        private let palette = [
            PaletteColor(id: 1, color: UIColor.black),
            PaletteColor(id: 2, color: UIColor.white),
            PaletteColor(id: 3, color: UIColor.red),
            PaletteColor(id: 4, color: UIColor.green),
            PaletteColor(id: 5, color: UIColor.blue),
            PaletteColor(id: 6, color: UIColor.yellow),
            PaletteColor(id: 7, color: UIColor.magenta),
            PaletteColor(id: 8, color: UIColor.cyan)
        ]
        
        @State var canvasArray: [Int]
        @State var currentSelectedColor: PaletteColor = PaletteColor(id: 1, color: .red)
        
        init(width: Int, height: Int) {
            self.pixelCountX = width
            self.pixelCountY = height
            self._canvasArray = State(initialValue: [Int](repeating: 2, count: height * width))
        }
        
        var body: some View {
            ZStack {
                VStack {
                    FreeDrawingView(width: self.pixelCountX, height: self.pixelCountY, palette: self.palette, currentColor: $currentSelectedColor, drawingBoard: self.$canvasArray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                }
                VStack {
                    PaletteView(palette: self.palette, currentColor: $currentSelectedColor)
                    //.border(Color.green)
                    Spacer()
                }
            }
            .navigationTitle("Custom pic")
            .toolbar {
                NavigationLink{
                    FreeDrawConfirmationScreen(width: self.pixelCountX, height: self.pixelCountY, palette: self.palette, pixelData: self.canvasArray)
                } label: {
                    Text("Done")
                }
                
            }
        }
        
        private func updateCanvasArray() {
            canvasArray = [Int](repeating: 2, count: pixelCountX * pixelCountY)
        }
    }
