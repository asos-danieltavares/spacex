import XCTest
import Models
@testable import SpaceX

final class CompanyViewModelTests: XCTestCase {

    // MARK: - Tests
    func test_initCompanyViewModel_withCompanyDetails_returnsExpectedString() {

        // GIVEN an instance of CompanyDetails
        let companyDetails = CompanyDetails.stub(name: "SpaceX")

        // WHEN CompanyViewModel is initialised with CompanyDetails & a number formatter
        let sut = CompanyViewModel(companyDetails: companyDetails, numberFormatter: .decimal)

        // THEN the companyInformation string matches our expected output
        XCTAssertEqual(expectedOutput(), sut.companyInformation)
    }

    // MARK: - Private Implementation Details
    private func expectedOutput() -> String {
        return "SpaceX was founded by Joe Bloggs in 2000. It has now 1,000 employees, 50 launch sites, and is valued at USD 1,000,000,000"
    }
}
