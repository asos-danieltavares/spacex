import XCTest
@testable import Models

final class CompanyDetailsDecodableTests: XCTestCase {

    // MARK: - Tests
    func test_decodeJSON_intoCompanyDetailsObject_withSuccess() throws {

        // GIVEN data from a JSON file
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        let data = try jsonData(fromFile: "companydetails")

        // WHEN the data is converted into a CompanyDetails object
        let companyDetails = try jsonDecoder.decode(CompanyDetails.self, from: data)

        // THEN the object matches our expected output
        XCTAssertEqual(companyDetails, expectedOutput())
    }

    // MARK: - Private Implementation Details
    private func expectedOutput() -> CompanyDetails {
        CompanyDetails(name: "SpaceX",
                       founder: "Elon Musk",
                       founded: 2002,
                       employees: 9500,
                       launchSites: 3,
                       valuation: 74000000000)
    }
}
