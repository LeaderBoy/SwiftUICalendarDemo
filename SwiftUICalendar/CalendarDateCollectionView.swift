//
//  CalendarDateCollectionView.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct CalendarDateCollectionView: View {
    
    @EnvironmentObject var calendarObj : CalendarObj

    var body: some View {
        VStack {
            ForEach(0..<self.numberOfRows(),id: \.self) { row in
                HStack(spacing:0) {
                    ForEach(1...self.numberOfColumns(),id: \.self) { column in
                        HStack {
                            Spacer(minLength: 0)
                            Text(self.dateIndex(for: row, column: column))
                            .frame(width: 44, height: 44)
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }
    
    func dateIndex(for row : Int,column : Int) -> String {
        let index = row * numberOfColumns() + column
        let days = numberOfDaysInMonth()
        if index > days {
            return ""
        }
        return "\(index)"
    }
    
    
    /// Days in specified month
    func numberOfDaysInMonth() -> Int {
        if let days = calendarObj.calendar.range(of: .day, in: .month, for: calendarObj.date) {
            return days.count
        }
        return 0
    }
    
    func numberOfRows() -> Int {
        let days = numberOfDaysInMonth()
        let columns = numberOfColumns()
        let number = days % columns
        if number == 0 {
            return days / columns
        } else {
            return days / columns + 1
        }
    }
    
    func numberOfColumns() -> Int {
        return 7
    }
}

struct CalendarDateCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarDateCollectionView()
            .previewLayout(.fixed(width: 400, height: 300))
            .environmentObject(CalendarObj())
            
            CalendarDateCollectionView()
            .previewLayout(.fixed(width: 320, height: 300))
            .environmentObject(CalendarObj())
        }
    }
}
