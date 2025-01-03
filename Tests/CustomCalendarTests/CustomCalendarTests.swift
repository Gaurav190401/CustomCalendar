import XCTest
@testable import CustomCalendar

final class CustomCalendarTests: XCTestCase {
    func testSelectedDate() {
        let viewModel = CalendarViewModel()
        XCTAssertEqual(
            Calendar.current.isDate(viewModel.selectedDate, inSameDayAs: Date()),
            true,
            "Initial selected date should be today"
        )
    }
}
