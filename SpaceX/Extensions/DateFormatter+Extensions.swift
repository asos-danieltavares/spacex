import Foundation

extension DateFormatter {

    static let dayMonthYear: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    static let hourMinutes: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "hh:mma"
        return dateFormatter
    }()
}
