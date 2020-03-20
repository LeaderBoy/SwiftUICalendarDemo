//
//  Date + Helper.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation


extension Date {
    
    func isSameDay(date:Date,in calendar : Calendar = .current) -> Bool {
        return calendar.isDate(date, inSameDayAs: self)
    }
    
    func addDay(by : Int ,in calendar : Calendar = .current) -> Date {
        return calendar.date(byAdding: .day, value: by, to: self)!
    }
    
    func numberOfDays(in calendar : Calendar = .current) -> Int {
        return calendar.range(of: .day, in: .month, for: self)!.count
    }
    
    func allDays(in calendar : Calendar = .current) -> [Date] {
        var dateComponents = DateComponents()
        var dates : [Date] = []
        for index in 0..<numberOfDays(in: calendar) {
            dateComponents.setValue(index, for: .day)
            let date = calendar.date(byAdding: dateComponents, to: firstDay()!)!
            dates.append(date)
        }
        return dates
    }
    
    func date(at index : Int) -> Date {
        let days = allDays()
        if days.count > index {
            return days[index]
        }
        assert(false ,"index 越界")
    }
    
    func firstDay(in calendar : Calendar = .current) -> Date? {
        if let interval = calendar.dateInterval(of: .month, for: self) {
            return interval.start.toLocalTime()
        }
        return nil
    }
    
    func lastDay(in calendar : Calendar = .current) -> Date? {
        if let interval = calendar.dateInterval(of: .month, for: self) {
            return interval.end
        }
        return nil
    }
    
    func days(in calendar : Calendar = .current) {
        let start = calendar.startOfDay(for: self)
        print("start\(start)")
//        if let start = startDay(in: calendar),let end = endDay(in:calendar) {
//            let components = calendar.dateComponents([.month], from: start, to: end)
//            print("components\(components)")
//        }
    }
    
    func toLocalTime() -> Date {
        let timezone    = TimeZone.current
        let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
