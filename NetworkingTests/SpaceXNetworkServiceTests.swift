import XCTest
import Models
@testable import Networking

final class SpaceXNetworkServiceTests: XCTestCase {

    // MARK: - Tests
    func test_initNetworkService_fetchSpaceXDetails_returnsExpectedOutput() throws {

        // GIVEN an instance of NetworkService with a stub API client and transformer
        let stubApiClient = StubAPIClient()
        let transformer = SpaceXDetailsTransformer()

        let sut = SpaceXNetworkService(apiClient: stubApiClient, transformer: transformer)

        // WHEN SpaceX details are requested
        let publisher = sut.fetchSpaceXDetails()

        // THEN the value matches our expectation
        let response = try await(publisher)

        XCTAssertEqual(expectedCompanyDetails(), response.company)
        XCTAssertEqual(1, response.launches.count)
    }

    // MARK: - Private Implementation Detaild
    private func expectedCompanyDetails() -> CompanyDetails {
        CompanyDetails(name: "SpaceX",
                       founder: "Joe Bloggs",
                       founded: 2000,
                       employees: 200,
                       launchSites: 50,
                       valuation: 1_000_000_000_000)
    }
}
