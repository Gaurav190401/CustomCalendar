//
//  File.swift
//  CustomCalendar
//
//  Created by Gaurav Harkhani on 03/01/25.
//

import SwiftUI

public struct CustomCalendarView: View {
    
    private let selectedDateColor: Color
    private let defaultTextColor: Color
    private let currentDateTextColor: Color
    @ObservedObject private var viewModel: CalendarViewModel

    public init(viewModel: CalendarViewModel,
                selectedDateColor: Color = .red,
                defaultTextColor: Color = .black,
                currentDateTextColor: Color = .blue) {
        self.viewModel = viewModel
        self.selectedDateColor = selectedDateColor
        self.defaultTextColor = defaultTextColor
        self.currentDateTextColor = currentDateTextColor
    }
    
    public var body: some View {
        VStack {
            datePickerView()
            if viewModel.isDatePickerVisible {
                selectedMonthView()
                weekDaysLabelView()
                calendarGridView()
            }
        }
    }

    @ViewBuilder
    private func datePickerView() -> some View {
        ZStack {
            HStack {
                Image(systemName: "calendar")
                Text("Select Date")
                    .font(.body)
                    .foregroundColor(Color.gray.opacity(0.6))
                Spacer()
                Button(action: {
                    withAnimation {
                        viewModel.isDatePickerVisible.toggle()
                    }
                }) {
                    Text(viewModel.selectedDate.toString(style: .medium))
                        .foregroundColor(Color.black)
                        .font(.system(size: 14))
                }
                .buttonStyle(.bordered)
                .tint(Color.gray)
            }
            .padding(10)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        }
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            withAnimation {
                viewModel.isDatePickerVisible.toggle()
            }
        }
    }

    @ViewBuilder
    private func selectedMonthView() -> some View {
        HStack {
            Button {
                viewModel.decrementMonth()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 12, height: 20)
                    .scaledToFit()
                    .foregroundColor(.black)
            }
            .disabled(viewModel.isAtMinDate)
            Spacer()
            Text(viewModel.selectedMonthAndYear)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                viewModel.incrementMonth()
            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 12, height: 20)
                    .scaledToFit()
                    .foregroundColor(.black)
            }
            .disabled(viewModel.isAtMaxDate)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    @ViewBuilder
    private func weekDaysLabelView() -> some View {
        HStack {
            ForEach(viewModel.weekDays, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func calendarGridView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(viewModel.dates, id: \.self) { date in
                ZStack {
                    let day = date.day
                    let isSelected = Calendar.current.isDate(date.date, equalTo: viewModel.selectedDate, toGranularity: .day)
                    let isToday = Calendar.current.isDate(date.date, equalTo: Date(), toGranularity: .day)
                    let hasEvent = viewModel.eventsByDate.map( { $0.toString(style: .medium) }).contains(Calendar.current.startOfDay(for: date.date).toString(style: .medium))
                    Text("\(day)")
                        .foregroundColor(isSelected ? .white : (isToday ? currentDateTextColor : defaultTextColor))
                        .background(
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isSelected ? selectedDateColor : .clear)
                        )
                        .onTapGesture {
                            viewModel.selectDate(date.date) // Use the new method here
                        }
                        .animation(.easeInOut(duration: 0.2), value: isSelected)
                    
                    if hasEvent {
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(.red)
                            .offset(x: 0, y: 12) // Positioning below the date
                    }
                }
                .frame(width: 32, height: 32, alignment: .center)
            }
        }
        .padding(.horizontal)
    }
}
