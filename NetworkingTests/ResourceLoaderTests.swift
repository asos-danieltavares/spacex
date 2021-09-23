import XCTest
import Combine
import Models
@testable import Networking

final class ResourceLoaderTests: XCTestCase {

    // MARK: - Tests
    func test_initResourceLoader_queryRocketsEndpoint_returnsListOfRockets() throws {

        // GIVEN an instance of ResourceLoader
        let sut = ResourceLoader()

        let url = try XCTUnwrap(URL(string: "https://api.spacexdata.com/v4/rockets"))
        let jsonDecoder = JSONDecoder()

        let expectation = self.expectation(description: "Fetch rockets from SpaceX API")

        // WHEN a resource is requested from the rockets endpoint
        let publisher = sut.fetchResource(forUrl: url,
                                          decodingType: [Rocket].self,
                                          jsonDecoder: jsonDecoder)
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { rockets in
                // THEN rockets will be returned
                XCTAssertTrue(rockets.count > 0)
            })

        XCTAssertNotNil(publisher)
        wait(for: [expectation], timeout: 10.0)
    }
}
