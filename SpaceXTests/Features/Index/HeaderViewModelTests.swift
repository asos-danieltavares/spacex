import XCTest
@testable import SpaceX

final class HeaderViewModelTests: XCTestCase {

    // MARK: - Tests
    func test_initWithCompanyInformation_matchesExpectedOutput() {

        // GIVEN a string
        let companyInformation = "Some company info"

        // WHEN HeaderViewModel is initialised with a company information string
        let sut = HeaderViewModel(companyInformation: companyInformation)

        // THEN the values match our expectation
        XCTAssertEqual(sut.companyInformation, companyInformation)
        XCTAssertEqual(sut.companyTitle, "Company")
        XCTAssertEqual(sut.launchesTitle, "Launches")
    }
}
