//
//  CalendarDateCollectionView.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI
import Combine

class PageManager : ObservableObject {
//    let objectWillChange = PassthroughSubject<Int,Never>()
    
    @Published var currentPage : Int = 0 {
        willSet {
            if newValue >= currentPage {
                direction = .forward
            } else {
                direction = .reverse
            }
            objectWillChange.send()
        }
        
        didSet {
            onPageChange?(currentPage,direction)
        }
    }
    
    var direction : UIPageViewController.NavigationDirection = .forward
    /// Bug: Prevent `ObservableObject` not call the updateView of `UIViewControllerRepresentable`
    /// https://stackoverflow.com/questions/58142942/swiftui-not-refresh-my-custom-uiview-with-uiviewrepresentable-observableobject
    var onPageChange: ((Int,UIPageViewController.NavigationDirection)->Void)?

}


struct CalendarDateCollectionView: View {
    
    @EnvironmentObject var obj : CalendarObj
    @State var state : CalendarCell.CellState = .normal
    @State var dataExample = (0 ..< 30).map { $0 }
    
    func pages() -> some View {
        VStack {
            ForEach(self.datesArray(),id: \.self) { rows in
                HStack(spacing:0) {
                    ForEach(rows,id: \.self) { column in
                        HStack {
                            Spacer(minLength: 0)
                            CalendarCell(date: column, state: self.$state)
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }

    var body: some View {
        VStack {
            PageView(pageManager: obj.pageManager, views: dataExample.map{ _ in pages()
            })
        }
//        .scaledToFit()
    }
    
//    func selected() -> Bool {
//          if obj.selectedDate == nil {
//              return obj.selectedDate.isSameDay(date: date)
//          }
//          return false
//    }
        
    /// Combine row and column for collectionView
    func datesArray() -> [[Date]] {
        var rowArray : [[Date]] = []
        let columns = numberOfColumns()
        let rows = numberOfRows()
        let days = self.obj.date.allDays()
        
        let placeholder = Date()
        
        for row in 0..<rows {
            var columnArray : [Date] = []
            for column in 0..<columns {
                let index = row * columns + column
                if days.count > index {
                    let d = days[index]
                    columnArray.append(d)
                } else {
                    columnArray.append(placeholder)
                }
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    func date(at index : Int) -> Date {
        return self.obj.date.date(at: index)
    }
    
    func date(at row: Int,column : Int) -> Date {
        let index = row * numberOfColumns() + column
        return date(at: index)
    }
    
    ///
    func dateComponents() -> DateComponents {
//        let index = row * numberOfColumns() + column
//        let days = numberOfDaysInMonth()
//        if index > days {
//            return ""
//        }
        let components =  obj.calendar.dateComponents([.year,.month,.day], from: obj.date)
        return components
    }
    
    
    func firstDayOf(date : Date) {
//        let calendar = calendarObj.calendar
//        let components = calendar.components([.Year, .Month], fromDate: date)
//        let startOfMonth = calendar.dateFromComponents(components)!
    }
    
//    func state(for day : Int) -> CalendarCell.CellState {
//
//    }
    
    /// Days in specified month
    func numberOfDaysInMonth() -> Int {
        if let days = obj.calendar.range(of: .day, in: .month, for: obj.date) {
            return days.count
        }
        return 0
    }
    
    /// Rows in specified month
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
    /// Column in specified month
    func numberOfColumns() -> Int {
        return 7
    }
    
    func isToday() {
        
    }
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
