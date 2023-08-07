//
//  User.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
struct User:Identifiable,Codable{
  @DocumentID  var id:String?
    var firstName:String
    var lastName:String
    var email:String
    var mobileNumber:Int
    var password:String
    var profileImageUrl:String
}
