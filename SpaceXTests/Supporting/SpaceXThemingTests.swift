import XCTest
@testable import SpaceX

final class SpaceXThemingTests: XCTestCase {

    func test_initSpaceXTheming_fetchBackgroundColor_matchesExpectation() {

        // GIVEN an instance of SpaceXTheming
        let sut = SpaceXTheming()

        // WHEN the background color is requested
        let backgroundColor = sut.backgroundColor

        // THEN the color matches our expectation
        XCTAssertEqual(backgroundColor, .systemBackground)
    }
}
