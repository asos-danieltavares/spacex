import XCTest
@testable import Models

final class LaunchResponseDecodableTests: XCTestCase {

    // MARK: - Tests
    func test_decodeJSON_intoLaunchArray_withSuccess() throws {

        // GIVEN data from a JSON file
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        let data = try jsonData(fromFile: "launches")

        // WHEN the data is converted into an array of Launch objects
        let launches = try jsonDecoder.decode([LaunchResponse].self, from: data)

        // THEN the result matches our expectation
        XCTAssertEqual(launches.count, 145)
    }
}
