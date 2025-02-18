//
//  File.swift
//  PixelArt
//
//  Created by vnc003 on 18.02.25.
//

import Foundation


struct User: Codable {
    var id: String
    var username: String
    var email: String
    var createdOn: Date
    var completedPixelArts: [String]
}
