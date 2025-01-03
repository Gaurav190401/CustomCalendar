//
//  File.swift
//  CustomCalendar
//
//  Created by Gaurav Harkhani on 03/01/25.
//

import Foundation
import SwiftUI

public class CalendarViewModel: ObservableObject {
    @Published public var selectedMonth: Date = Date()
    @Published public var selectedDate: Date {
        didSet {
            // Prevent unnecessary updates if the date is the same
            if calendar.isDate(selectedDate, equalTo: oldValue, toGranularity: .day) {
                selectedDate = oldValue
            }
        }
    }
    @Published public var isDatePickerVisible: Bool = false
    @Published public var isAtMinDate: Bool = false
    @Published public var isAtMaxDate: Bool = false
    @Published public var eventsByDate: [Date] = []
    
    private var calendar = Calendar.current
    private var minDate: Date?
    private var maxDate: Date?

    // MARK: - Initializer
    public init(initialDate: Date = Date(), minDate: Date? = nil, maxDate: Date? = nil) {
        self.selectedDate = initialDate
        self.minDate = minDate
        self.maxDate = maxDate
        updateMinMaxDateFlags()
    }
    
    // MARK: - Date Formatting
    public var selectedMonthAndYear: String {
        return formattedDate(selectedMonth, format: "MMMM yyyy")
    }
    
    public var weekDays: [String] {
        return calendar.shortWeekdaySymbols
    }
    
    // MARK: - Dates Logic
    public var dates: [CalendarDate] {
        return generateDatesForMonth(selectedMonth)
    }
    
    // MARK: - Date Selection
    public func selectDate(_ date: Date) {
        if !calendar.isDate(date, equalTo: selectedDate, toGranularity: .day) {
            selectedDate = date
        }
    }

    public func incrementMonth() {
        updateMonth(by: 1)
    }

    public func decrementMonth() {
        updateMonth(by: -1)
    }
    
    // MARK: - Min/Max Date Handling
    public func setMinMaxDates(minDate: Date?, maxDate: Date?) {
        self.minDate = minDate
        self.maxDate = maxDate
        updateMinMaxDateFlags()
    }

    // MARK: - Private Methods
    private func formattedDate(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    private func generateDatesForMonth(_ month: Date) -> [CalendarDate] {
        var dates: [CalendarDate] = []
        let range = calendar.range(of: .day, in: .month, for: month)!
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                dates.append(CalendarDate(day: day, date: date))
            }
        }
        
        return dates
    }
    
    private func updateMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: selectedMonth) {
            selectedMonth = newMonth
        }
        updateMinMaxDateFlags()
    }
    
    private func updateMinMaxDateFlags() {
        isAtMinDate = (minDate != nil && calendar.compare(selectedMonth, to: minDate!, toGranularity: .month) == .orderedSame)
        isAtMaxDate = (maxDate != nil && calendar.compare(selectedMonth, to: maxDate!, toGranularity: .month) == .orderedSame)
    }
}
