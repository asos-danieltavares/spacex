import XCTest
@testable import Models

final class RocketDecodableTests: XCTestCase {

    // MARK: - Tests
    func test_decodeJSON_intoRocketsArray_withSuccess() throws {

        // GIVEN data from a JSON file
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        let data = try jsonData(fromFile: "rockets")

        // WHEN the data is converted into an array of Rockets
        let rockets = try jsonDecoder.decode([Rocket].self, from: data)

        // THEN the array matches our expected output
        XCTAssertEqual(rockets.count, 4)
    }
}
