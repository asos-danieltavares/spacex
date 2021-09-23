import XCTest
@testable import Localization

final class LocalizedStringTests: XCTestCase {

    func test_fetchLocalizedStrings_valuesPresentForAll() {

        // GIVEN an array of LocalizedStrings
        let sut = LocalizedString.allCases

        // WHEN we fetch a string for each value
        sut.forEach { localizedString in

            // THEN the string value does not match the key
            let string = String(localizedString)

            XCTAssertNotEqual(localizedString.rawValue, string)
        }
    }
}
