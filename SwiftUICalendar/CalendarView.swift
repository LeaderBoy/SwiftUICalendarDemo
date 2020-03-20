//
//  CalendarView.swift
//  CalendarView
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var calendarObj : CalendarObj
    
    var body: some View {
        VStack {
            CalendarToolBar()
            CalendarWeekBar()
            CalendarDateCollectionView()
        }.padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarObj())
    }
}
