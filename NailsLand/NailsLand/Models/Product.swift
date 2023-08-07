//
//  Product.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import Foundation
struct Product:Identifiable,Codable{
    var id = UUID().uuidString
    var image:String
    var productName:String
    var price:Double
}

var products = [
    Product(image: "k1", productName: "Naturaly family", price: 199.99),
    Product(image: "k2", productName: "Crystal gel", price: 49.99),
    Product(image: "k3", productName: "Eyes slpaher", price: 19.99)
]
