//
//  PalleteColor.swift
//  PixelArt
//
//  Created by vnc003 on 19.02.25.
//

import Foundation
import SwiftUI

struct PaletteColor: Hashable, Codable {
    let id: Int
    let color: String
    
    init(id: Int, color: UIColor) {
        self.id = id
        self.color = color.toHexString()
    }
    
    var uiColor: UIColor {
            return UIColor(hex: color) ?? .black
        }
}
