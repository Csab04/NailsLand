//
//  Tab.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import Foundation
import SwiftUI
enum Tab:String {
    case home
    case location
    case shop
    case profile
}


struct TabItem:Identifiable{
    var id = UUID()
    var text:String
    var icon:String
    var tab:Tab
    var color:Color
}

var tabItems = [
    TabItem(text: "Home", icon: "house.fill", tab: .home, color: .red),
    TabItem(text: "Shop", icon: "bag.fill", tab: .shop, color: .blue),
    TabItem(text: "Map", icon: "map.fill", tab: .location, color: .teal),
    TabItem(text: "Apoiment", icon: "calendar", tab: .profile, color: .pink),
]
