import XCTest
@testable import Networking

final class EndpointTests: XCTestCase {

    // MARK: - Tests
    func test_initEndpointWithUrlAndQueryItem_returnsExpectedOutput() throws {

        // GIVEN an endpoint with a path and queryItem
        let endpoint = Endpoint(path: "/someurl",
                                queryItems: [.init(name: "q", value: "a")])

        // WHEN a URL is requested
        let url = try XCTUnwrap(endpoint.url)

        // THEN the values matches
        XCTAssertEqual("https://api.spacexdata.com/someurl?q=a", url.absoluteString)
    }
}
