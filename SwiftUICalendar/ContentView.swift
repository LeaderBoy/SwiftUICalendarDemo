//
//  ContentView.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

class CalendarObj : ObservableObject {
    @Published var calendar : Calendar = .current
    @Published var date : Date = Date()
    
}

struct ContentView: View {
    
    @ObservedObject var calendarObj = CalendarObj()
    
    var body: some View {
        CalendarView().environmentObject(calendarObj)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
