//
//  CalendarToolBar.swift
//  CalendarView
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct CalendarToolBar: View {
    
    @EnvironmentObject var calendarObj : CalendarObj
    
    var components : DateComponents {
        return calendarObj.calendar.dateComponents([.year,.month,.day], from: calendarObj.date)
    }
    
    var year : Int  {
        return components.year!
    }
    
    var month : Int {
        return components.month!
    }
    
    var shortMonthSymbols : String {
        return calendarObj.calendar.shortMonthSymbols[month - 1]
    }
    
    var yearSymbols : String {
        return "\(year)"
    }
    
    var foreColor : Color = .blue
    
    var body: some View {
        HStack {
            HStack(spacing:30) {
                PendantView()
                HStack {
                    Text("\(shortMonthSymbols)")
                    .font(.system(size: 25, weight: .bold))
                    Text("\(yearSymbols) ")
                    .font(.system(size: 25, weight: .bold))
                }
            }
            Spacer()
            HStack(spacing:20) {
                Button(action: {
                    
                }) {
                    Image(systemName: "tv.fill")
                }
                Button(action: {
                    
                }) {
                    Image(systemName: "tv.fill")
                }
            }.padding()
        }.foregroundColor(foreColor)
    }
}

struct CalendarToolBar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarToolBar().environmentObject(CalendarObj())
    }
}
