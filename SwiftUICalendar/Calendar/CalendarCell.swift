//
//  CalendarCell.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var obj : CalendarObj
    
    var holderDate : HolderDate
    
    @Binding var state : CellState
    
    enum CellState {
        case normal
        case selected
        case current
        case disabled
        
        func stateBackColor() -> Color {
            switch self {
            case .normal:
                return .white
            case .selected:
                return .blue
            case .current:
                return .red
            case .disabled:
                return .gray
            }
        }

        func stateTextColor() -> Color {
            switch self {
            case .normal:
                return .black
            case .selected:
                return .white
            case .current:
                return .white
            case .disabled:
                return .black
            }
        }
    }

    var body: some View {
        Button(action: {
            if self.state == .selected {
                self.state = .normal
            } else {
                self.state = .selected
            }
        }) {
            Text(self.day())
        }
        .frame(width: 44, height: 44)
        .foregroundColor(state.stateTextColor())
        .background(state.stateBackColor())
        .clipShape(Circle())
    }
    
    func day() -> String {
        if let date = holderDate.date {
            let components = obj.calendar.dateComponents([.day], from: date)
            return "\(components.day!)"
        }
        return ""
    }
    
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarCell(holderDate: HolderDate(date:Date()), state: .constant(.normal))
            .previewDisplayName("Normal")

            CalendarCell(holderDate: HolderDate(date:Date()), state: .constant(.current))
            .previewDisplayName("Current")

            CalendarCell(holderDate: HolderDate(date:Date()), state: .constant(.selected))
            .previewDisplayName("Selected")

            CalendarCell(holderDate: HolderDate(date:Date()), state: .constant(.disabled))
            .previewDisplayName("Disabled")
        }.previewLayout(.fixed(width: 300, height: 100))
    }
}
