//
//  DataModels.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 16.02.25.
//

import SwiftUI

struct PaletteColor: Hashable {
    let id: Int
    let color: UIColor
}

struct PixelPictureDataModel {
    let id: String
    let name: String
    let width: Int
    let height: Int
    let palette: [PaletteColor]
    let pixelData: [Int]
    
    init(id: String, name: String, width: Int, height: Int, palette: [PaletteColor], pixelData: [Int]) {
        self.id = id
        self.name = name
        self.width = width
        self.height = height
        self.palette = palette
        self.pixelData = pixelData
    }
    
    func getDataAt(x: Int, y: Int) -> Int {
        return pixelData[x * height + y]
    }
    
}
