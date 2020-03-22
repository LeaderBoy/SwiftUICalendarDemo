//
//  CalendarDateCollectionView.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct CalendarDateCollectionView: View {
    
    @EnvironmentObject var obj : CalendarObj
    @State var state : CalendarCell.CellState = .normal
    
    var body: some View {
        VStack {
            PageView(pageManager: obj.pageManager, views:[self.page()])
        }
    }

    func page() -> some View {
        VStack {
            ForEach(self.datesArray(),id: \.self) { rows in
                HStack(spacing:0) {
                    ForEach(rows,id: \.self) { column in
                        HStack {
                            Spacer(minLength: 0)
                            CalendarCell(holderDate: column)
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }
    
    /// Combine row and column for collectionView
    func datesArray() -> [[HolderDate]] {
        var rowArray : [[HolderDate]] = []
        let columns = numberOfColumns()
        let rows = numberOfRows()
        let days = self.obj.date.allDays()
        let placeholder = HolderDate(date: nil)
        let offset = dayOffset()
        
        for row in 0..<rows {
            var columnArray : [HolderDate] = []
            for column in 0..<columns {
                let index = row * columns + column
                if index < offset || days.count <= (index - offset) {
                    columnArray.append(placeholder)
                } else {
                    let d = days[index - offset]
                    columnArray.append(HolderDate(date: d))
                }
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    /// Rows in specified month
    func numberOfRows() -> Int {
        let actualDays = obj.date.numberOfDays()
        let offset = dayOffset()
        let days = actualDays + offset
        let columns = numberOfColumns()
        let number = days % columns
        if number == 0 {
            return days / columns
        } else {
            return days / columns + 1
        }
    }
    /// Column in specified month
    func numberOfColumns() -> Int {
        return 7
    }
    
    func dayOffset() -> Int {
        return obj.date.firstDayOfWeek() - 1
    }
}

struct HolderDate : Hashable {
    let date : Date?
}

struct CalendarDateCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarDateCollectionView()
//            .previewLayout(.fixed(width: 400, height: 300))
            .environmentObject(CalendarObj())
//
//            CalendarDateCollectionView()
//            .previewLayout(.fixed(width: 320, height: 300))
//            .environmentObject(CalendarObj())
        }
    }
}
