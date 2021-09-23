import XCTest
@testable import Networking

final class APIClientTests: XCTestCase {

    // MARK: - Tests
    func test_initEndpointPaths_ensureAllAreValid() {

        SpaceXAPIClient.EndpointPath.allCases.forEach { endpoint in
            XCTAssertNotNil(endpoint.url)
            XCTAssertNoThrow(endpoint.url)
        }
    }

    func test_initAPIClientWithStubResourceLoader_fetchRockets_returnsSuccess() throws {

        // GIVEN an instance of SpaceXAPIClient is instantiated with a stub resource loader
        let stubResourceLoader = StubResourceLoader(requestType: .rockets)
        let sut = SpaceXAPIClient(resourceLoader: stubResourceLoader)

        // WHEN rockets are fetched
        let publisher = sut.fetchRockets()
        let rockets = try await(publisher)

        // THEN the results are as expected
        XCTAssertEqual(rockets.count, 1)

        let expectedRocketNames = ["Falcon"]
        let actualRocketNames = rockets.map { $0.name }

        XCTAssertEqual(expectedRocketNames, actualRocketNames)
    }
}
