import XCTest
import Models
@testable import Networking

final class SpaceXDetailsTransformerTests: XCTestCase {

    // MARK: - Properties
    private let currentDate = Date()

    // MARK: - Tests
    func test_init_transformResponses_intoSpaceXDetailsObject() {

        // GIVEN an instance of SpaceXDetailsTransformer
        let sut = SpaceXDetailsTransformer()

        // WHEN a series of objects - `CompanyDetails`, `LaunchResponse` array and `Rockets` array are transformed
        let companyDetails = CompanyDetails.stub(name: "SpaceX")
        let launch = LaunchResponse.stub(name: "Some launch", date: currentDate)
        let rocket = Rocket.stub(name: "some-rocket")

        let output = sut.transform(companyDetails: companyDetails,
                                   launches: [launch],
                                   rockets: [rocket])

        // THEN the output is as expected
        XCTAssertEqual(expectedOutput(), output)
    }

    // MARK: - Private Implementation Details
    private func expectedOutput() -> SpaceXDetails {
        let companyDetails = CompanyDetails.stub(name: "SpaceX")
        let launch = Launch.stub(name: "Some launch", date: currentDate)

        return SpaceXDetails(company: companyDetails,
                             launches: [launch])
    }
}
