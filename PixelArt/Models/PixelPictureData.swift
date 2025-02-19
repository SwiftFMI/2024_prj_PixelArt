//
//  DataModels.swift
//  uniproj
//
//  Created by Ivaylo Atanasov on 16.02.25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreCombineSwift


struct PixelPictureData: Codable {
    let id: String
    let name: String
    let createdBy: String
    let createdOn: Date
    let width: Int
    let height: Int
    let palette: [PaletteColor]
    let pixelData: [Int]
    let pixelMemory: [Int]
    
    init(id: String,
         name: String,
         createdBy: String,
         createdOn: Date,
         width: Int,
         height: Int,
         palette: [PaletteColor],
         pixelData: [Int],
         pixelMemory: [Int]) {
        
        self.id = id
        self.name = name
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.width = width
        self.height = height
        self.palette = palette
        self.pixelData = pixelData
        self.pixelMemory = pixelMemory
    }
    
    func getDataAt(x: Int, y: Int) -> Int {
        return pixelData[x * height + y]
    }
    
    func getMemoryAt(x: Int, y: Int) -> Int {
        return pixelMemory[x * height + y]
    }
    
}
