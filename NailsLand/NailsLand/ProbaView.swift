//
//  ProbaView.swift
//  NailsLand
//
//  Created by Csaba Otvos on 30.03.2023.
//

import SwiftUI

struct CalendarsokView: View {
    let calendar = Calendar.current
    let appointments: [Appoiment]  = []// This should be an array of appointments

    var body: some View {
        VStack {
//            MonthPicker()
//            WeekdayLabels()

            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(monthDates(), id: \.self) { date in
                        HStack(spacing: 0) {
                            ForEach(0..<7) { weekday in
                                DayCell(date: date, weekday: weekday, appointments: appointments)
                            }
                        }
                    }
                }
            }
        }
    }

    func monthDates() -> [Date] {
        let today = Date()
        let month = calendar.dateComponents([.year, .month], from: today)
        let startOfMonth = calendar.date(from: month)!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let startWeekday = calendar.component(.weekday, from: startOfMonth)
        let numberOfWeeks = calendar.range(of: .weekOfMonth, in: .month, for: startOfMonth)!.count
        var dates: [Date] = []
        for week in 0..<numberOfWeeks {
            for day in 0..<7 {
                let date = calendar.date(byAdding: .day, value: (day + week * 7) - (startWeekday - 1), to: startOfMonth)!
                dates.append(date)
            }
        }
        return dates
    }
}

struct CalendarsokView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarsokView()
    }
}


struct DayCell: View {
    let date: Date
    let weekday: Int
    let appointments: [Appoiment]
    
    var body: some View {
        VStack {
            if isCurrentMonth() {
                Text(dayOfMonth())
                    .font(.headline)
                    .foregroundColor(isToday() ? .accentColor : .primary)
                
                ForEach(appointmentsForDate(date: date)) { appointment in
                    Text(appointment.time)
                        .font(.caption)
                }
            } else {
                Text("")
                    .hidden()
            }
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
    }
    
    func dayOfMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        return components == todayComponents
    }
    
    func isCurrentMonth() -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        let todayComponents = calendar.dateComponents([.year, .month], from: Date())
        return components == todayComponents
    }
    
    func appointmentsForDate(date: Date) -> [Appoiment] {
        return appointments.filter { appointment in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: appointment.date)
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            return components == dateComponents
        }
    }
}
