//
//  Appoiment.swift
//  NailsLand
//
//  Created by Csaba Otvos on 23.03.2023.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
struct AppoimentDate:Identifiable,Codable{
    @DocumentID var id: String?
    var textTime:String
    var date:Date
    var day: String {
        date.displayFormatForSectiomHeader
    }
   
}


struct Appoiment:Identifiable,Codable{
    @DocumentID var id:String?
    var date:Date
    var time:String
    var name:[String]
    var email:String
    var mobileNumber:Int
    var profileImageUrl:String
    var service:String
    var price:Double
    var uid:String
}
