//
//  CalendarCell.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct CalendarCell: View {
    
    var text : String
    @Binding var state : State
    
    enum State {
        case normal
        case selected
        case current
        case disabled
    }
    
    var body: some View {
        Text(text)
            .padding()
            .foregroundColor(stateTextColor())
            .background(stateBackColor())
            .clipShape(Circle())
    }
    
    func stateBackColor() -> Color {
        switch state {
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
        switch state {
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

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarCell(text: "12", state: .constant(.normal))
            .previewDisplayName("Normal")

            CalendarCell(text: "12", state: .constant(.current))
            .previewDisplayName("Current")

            CalendarCell(text: "12", state: .constant(.selected))
            .previewDisplayName("Selected")

            CalendarCell(text: "12", state: .constant(.disabled))
            .previewDisplayName("Disabled")
        }.previewLayout(.fixed(width: 300, height: 100))
    }
}
