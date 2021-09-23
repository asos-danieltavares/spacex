import XCTest
@testable import SpaceX

final class SequenceExtensionTests: XCTestCase {

    // MARK: - Tests
    func test_arrayOfIntsWithDuplicates_filterUniqueValues_returnsExpectedResult() {

        // GIVEN an array of integers with duplicate entries
        let numbers: [Int] = [2020, 2021, 2022, 2020, 2021, 2022]

        // WHEN the unique function is called
        let uniqueNumbers = numbers.unique()

        // THEN the result matches our expectation
        XCTAssertEqual(uniqueNumbers, [2020, 2021, 2022])
    }
}
