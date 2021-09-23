import XCTest
@testable import SpaceX

final class SpaceXTypographyTests: XCTestCase {

    func test_initTypography_fetchListPlaceholderTitle_attributesMatchExpectation() throws {

        // GIVEN an instance of SpaceXTypography
        let sut = SpaceXTypography()

        // WHEN typography for a `listPlaceholderTitle` is requested
        let typography = sut.listPlaceholderTitle()

        // THEN the attributes are as expected
        let font = try XCTUnwrap(typography[.font] as? UIFont)
        let foregroundColor = try XCTUnwrap(typography[.foregroundColor] as? UIColor)

        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .caption2))
        XCTAssertEqual(foregroundColor, .label)
    }

    func test_initTypography_fetchListTitle_attributesMatchExpectation() throws {

        // GIVEN an instance of SpaceXTypography
        let sut = SpaceXTypography()

        // WHEN typography for a `listTitle` is requested
        let typography = sut.listTitle()

        // THEN the attributes are as expected
        let font = try XCTUnwrap(typography[.font] as? UIFont)
        let foregroundColor = try XCTUnwrap(typography[.foregroundColor] as? UIColor)

        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .caption2))
        XCTAssertEqual(foregroundColor, .label)
    }

    func test_initTypography_fetchFilterHeading_attributesMatchExpectation() throws {

        // GIVEN an instance of SpaceXTypography
        let sut = SpaceXTypography()

        // WHEN typography for `filterHeading` is requested
        let typography = sut.filterHeading()

        // THEN the attributes are as expected
        let font = try XCTUnwrap(typography[.font] as? UIFont)
        let foregroundColor = try XCTUnwrap(typography[.foregroundColor] as? UIColor)

        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .headline))
        XCTAssertEqual(foregroundColor, .label)
    }

    func test_initTypography_fetchFilterButtonTitle_attributesMatchExpectation() throws {

        // GIVEN an instance of SpaceXTypography
        let sut = SpaceXTypography()

        // WHEN typography for `filterButtonTitle` is requested
        let typography = sut.filterButtonTitle()

        // THEN the attributes are as expected
        let font = try XCTUnwrap(typography[.font] as? UIFont)
        let foregroundColor = try XCTUnwrap(typography[.foregroundColor] as? UIColor)

        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(foregroundColor, .label)
    }
}
