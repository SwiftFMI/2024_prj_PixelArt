//
//  FreeDrawScreen.swift
//  PixelArt
//
//  Created by Ivaylo Atanasov on 19.02.25.
//

import SwiftUI



struct FreeDrawScreen: View {
    @State private var pixelCount: Int = 8
    
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
    
    @State private var canvasArray: [Int] = [Int](repeating: 2, count: 8 * 8)
    @State private var currentSelectedColor: PaletteColor = PaletteColor(id: 1, color: .red)
    
    private let sizeOptions = [2, 4, 8, 16, 32, 64]
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Size", selection: $pixelCount) {
                    ForEach(sizeOptions, id: \.self) { size in
                        Text("\(size)x\(size)").tag(size)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
                .onChange(of: pixelCount) { _ in
                    updateCanvasArray()
                }

                FreeDrawingView(
                    width: self.pixelCount,
                    height: self.pixelCount,
                    palette: self.palette,
                    currentColor: $currentSelectedColor,
                    drawingBoard: self.$canvasArray
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            VStack {
                PaletteView(palette: self.palette, currentColor: $currentSelectedColor)
                Spacer()
            }
        }
        .navigationTitle("Custom pic")
        .toolbar {
            NavigationLink {
                FreeDrawConfirmationScreen(
                    width: self.pixelCount,
                    height: self.pixelCount,
                    palette: self.palette,
                    pixelData: self.canvasArray
                )
            } label: {
                Text("Done")
            }
        }
    }
    
    private func updateCanvasArray() {
        canvasArray = [Int](repeating: 2, count: pixelCount * pixelCount)
    }
}


