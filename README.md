# CustomCalendar Package

## Overview
The `CustomCalendar` Swift Package provides a customizable calendar component for iOS applications. It offers an easy-to-use interface, customizable colors, and features such as month navigation, event highlighting, and date selection.

---

## Features
- **Date Picker View**: Allows users to select dates with a clean, interactive UI.
- **Month Navigation**: Navigate through months using intuitive buttons.
- **Weekday Labels**: Displays weekday headers for the calendar.
- **Event Highlighting**: Mark specific dates with events.
- **Customizable Appearance**: Change colors.
- **Today Highlight**: Highlights today's date with a custom color.

---

## Installation
### Using Swift Package Manager (SPM)
1. Open your Xcode project.
2. Go to `File > Add Packages...`.
3. Paste the repository URL: `https://github.com/your-username/CustomCalendar`
4. Choose the latest version and click `Add Package`.

---

## Usage
### Import the Package
```swift
import CustomCalendar
```

### Initialize the Calendar
In your SwiftUI view, use the `CustomCalendarView`:

```swift
import SwiftUI
import CustomCalendar

struct ContentView: View {
    @StateObject private var viewModel = CalendarViewModel()

    var body: some View {
        CustomCalendarView(viewModel: viewModel)
            .padding()
    }
}
```

---

## Customization
You can customize various aspects of the calendar by providing additional parameters to `CustomCalendarView`.

### Example with Custom Colors:
```swift
CustomCalendarView(
    viewModel: viewModel,
    selectedDateColor: .red,
    defaultTextColor: .gray,
    currentDateTextColor: .blue
)
```

### Customizing Min and Max Dates
Set minimum and maximum selectable dates directly in the `CalendarViewModel`:

```swift
viewModel.setMinMaxDates(
    minDate: Calendar.current.date(byAdding: .month, value: -1, to: Date()),
    maxDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())
)
```

---

## API Reference

### **CustomCalendarView**
A SwiftUI view that renders the calendar.

- **Parameters**:
  - `viewModel: CalendarViewModel` - The view model to manage calendar data.
  - `selectedDateColor: Color` - The color of the selected date (default: `.red`).
  - `defaultTextColor: Color` - The color of the calendar text (default: `.black`).
  - `currentDateTextColor: Color` - The color of today's date text (default: `.blue`).

---

### **CalendarViewModel**
The view model that provides data and handles logic for the calendar.

- **Properties**:
  - `selectedDate: Date` - The currently selected date.
  - `selectedMonth: Date` - The currently displayed month.
  - `isDatePickerVisible: Bool` - A flag to toggle the date picker view.
  - `isAtMinDate: Bool` - A flag indicating if the calendar is at the minimum date.
  - `isAtMaxDate: Bool` - A flag indicating if the calendar is at the maximum date.
  - `eventsByDate: [Date]` - An array of event dates to highlight.

- **Methods**:
  - `selectDate(_ date: Date)` - Selects a specific date.
  - `incrementMonth()` - Moves to the next month.
  - `decrementMonth()` - Moves to the previous month.
  - `setMinMaxDates(minDate: Date?, maxDate: Date?)` - Sets the minimum and maximum dates for the calendar.

---

## Examples

### Highlighting Event Dates
You can highlight specific event dates by passing an array of event dates to the view model:

```swift
viewModel.eventsByDate = [
    Calendar.current.startOfDay(for: Date()),
    Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: 5, to: Date())!)
]
```

### Customize Appearance
```swift
CustomCalendarView(
    viewModel: viewModel,
    selectedDateColor: .green,
    defaultTextColor: .black,
    currentDateTextColor: .purple
)
```

### Disable Navigation at Min/Max Date
The `isAtMinDate` and `isAtMaxDate` flags in the `CalendarViewModel` automatically disable month navigation when at the minimum or maximum date.

---

## Testing
Write unit tests to ensure the functionality works as expected. Example:

```swift
import XCTest
import CustomCalendar

final class CustomCalendarTests: XCTestCase {
    func testSelectedDate() {
        let viewModel = CalendarViewModel()
        XCTAssertEqual(viewModel.selectedDate, Date(), "Initial selected date should be today")
    }
}
```

---

## Contributions
We welcome contributions! Feel free to submit pull requests or report issues.

---

## License
This package is available under the MIT license. See the LICENSE file for more information.
