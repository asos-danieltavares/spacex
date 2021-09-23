import XCTest
@testable import SpaceX

final class OptionalExtensionTests: XCTestCase {

    // MARK: - Tests
    func test_initOptionalStringWithNilValue_isEmptyCalled_returnsExpectedOutput() {

        // GIVEN an optional string with a nil value
        let optionalString: String? = nil

        // WHEN `orEmpty` is called
        let string = optionalString.orEmpty()

        // THEN the value returns an empty string
        XCTAssertEqual("", string)
    }

    func test_initOptionalString_isEmptyCalled_returnsExpectedOutput() {

        // GIVEN an string with an initial value
        let optionalString: String? = "some_string"

        // WHEN `orEmpty` is called
        let string = optionalString.orEmpty()

        // THEN the value returns an empty string
        XCTAssertEqual("some_string", string)
    }
}
