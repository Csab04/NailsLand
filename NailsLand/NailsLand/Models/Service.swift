//
//  Service.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import Foundation
import SwiftUI

enum ServiceTab:String ,CaseIterable{
    case eyebrow
    case makeup
    case nails
}
struct Service:Identifiable{
    var id = UUID().uuidString
    var imageName:String
    var name:String
    var price:Double
    var serviceTab:ServiceTab
}

let service = [
    Service(imageName: "eyebrow", name: "eyebrow ", price: 10.99,serviceTab: .eyebrow),
    Service(imageName: "mouth.fill", name: "makeup ", price: 50.99,serviceTab: .makeup),
    Service(imageName: "hand.raised.fill", name: "nails", price: 40.99,serviceTab: .nails)

]
