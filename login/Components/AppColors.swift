//
//  AppColors.swift
//  login
//
//  Created by Floki on 15/4/2023.
//

import Foundation
import SwiftUI


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct AppColors{
    static let primary = Color(red:227/255 , green: 245/255 , blue: 255/255)
    static let primary2 = Color(red:30/255 , green:35/255 , blue:55/255)
    static let primary3 = Color(red:110/255 , green: 205/255 , blue: 187/255)
    
}
