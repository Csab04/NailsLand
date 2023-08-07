//
//  Extensions.swift
//  NailsLand
//
//  Created by Csaba Otvos on 15.03.2023.
//

import Foundation
import SwiftUI


extension Color {
    static let purpleBG = "purpleBG"
}
 

extension View {
   
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}


extension Date {
    var displayFormatForSectiomHeader:String {
        self.formatted(
            .dateTime
                .month(.wide)
                .day(.twoDigits)
            
            )
    }
    
    func toString(_ format: String) -> String{
        let forrmater = DateFormatter()
        forrmater.dateFormat = format
        return forrmater.string(from: self)
    }
    
    
}
 


extension Calendar {
    var currentWeek:[Weekday] {
        guard let firstWeekday = self.dateInterval(of: .weekOfMonth, for: Date())?.start else {
            return []
        }
        
        var week : [Weekday] = []
        for index in 0...7 {
            if let day = date(byAdding: .day, value: index, to: firstWeekday){
                let weekDaySymbol:String = day.toString("EEEE")
               let _ = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day))
            }
        }
        return week
    }
    
    
    struct Weekday:Identifiable {
        var id : UUID = .init()
        var string:String
        var date:Date
        var isToday:Bool = false
    }
}
