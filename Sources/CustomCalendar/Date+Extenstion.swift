//
//  File.swift
//  CustomCalendar
//
//  Created by Gaurav Harkhani on 03/01/25.
//

import Foundation

extension Date {
    /// Converts a Date to a formatted string using a specified style.
    func toString(style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
