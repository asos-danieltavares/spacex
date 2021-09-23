import XCTest
@testable import SpaceX

final class DateExtensionTests: XCTestCase {

    // MARK: - Tests
    func test_initDate_convertToHourMinutesFormat_returnsExpectedOutput() {

        // GIVEN a date
        let date = Date(timeIntervalSince1970: 1632158004)

        // WHEN converting to hour and minutes format
        let hourMinutes = date.hourMinutes()

        // THEN the value matches our expected output
        XCTAssertEqual("05:13PM", hourMinutes)
    }

    func test_initDate_convertToDayMonthYearFormat_returnsExpectedOutput() {

        // GIVEN a date
        let date = Date(timeIntervalSince1970: 1632158004)

        // WHEN converting to day, month and year format
        let dayMonthYear = date.dayMonthYear()

        // THEN the value matches our expected output
        XCTAssertEqual("20/09/2021", dayMonthYear)
    }

    func test_initTwoDates_getPositiveNumberOfDaysBetween_returnsExpectedOutput() throws {

        // GIVEN 2 dates
        let today = Date()
        let nextWeek = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: 7, to: today))

        // WHEN requesting the number of days between the 2 dates
        let numberOfDays = today.days(betweenDate: nextWeek)

        // THEN the value matches our expected output
        XCTAssertEqual(7, numberOfDays)
    }

    func test_initTwoDates_getNegativeNumberOfDaysBetween_returnsExpectedOutput() throws {

        // GIVEN 2 dates
        let today = Date()
        let twoWeeksAgo = try XCTUnwrap(Calendar.current.date(byAdding: .day, value: -14, to: today))

        // WHEN requesting the number of days between the 2 dates
        let numberOfDays = today.days(betweenDate: twoWeeksAgo)

        // THEN the value matches our expected output
        XCTAssertEqual(14, numberOfDays)
    }
}
