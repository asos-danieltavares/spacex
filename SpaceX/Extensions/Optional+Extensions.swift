import Foundation

extension Optional where Wrapped == String {

    func orEmpty() -> String {
        self ?? ""
    }
}
