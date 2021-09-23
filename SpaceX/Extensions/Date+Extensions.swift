import Foundation

extension Date {

    func hourMinutes() -> String {
        DateFormatter.hourMinutes.string(from: self)
    }

    func dayMonthYear() -> String {
        DateFormatter.dayMonthYear.string(from: self)
    }

    func days(betweenDate date: Date) -> Int {

        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: date)

        return abs(components.day ?? 0)
    }
}
