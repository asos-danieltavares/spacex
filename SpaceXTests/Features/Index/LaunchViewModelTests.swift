import XCTest
import Models
@testable import SpaceX

final class LaunchViewModelTests: XCTestCase {

    // MARK: - Tests
    func test_initViewModel_withLaunchAndDate_matchesExpectedOutput() throws {

        // GIVEN a `Launch` object, number formatter, URL and date
        let date = Date(timeIntervalSince1970: 1632409531)
        let url = try XCTUnwrap(URL(string: "https://spacex.com"))
        let numberFormatter = NumberFormatter.decimal

        let launch = Launch(name: "some launch",
                            launchDate: date,
                            landingSuccessful: true,
                            links: [],
                            patchImageUrl: url,
                            rocketName: "some rocket",
                            rocketType: "rocket")

        // WHEN a view model is initialised
        let sut = LaunchViewModel(launch, todaysDate: date, numberFormatter: numberFormatter)

        // THEN the response matches our expected output
        let expectedOutput = createMockViewModel(date: date, url: url)

        XCTAssertEqual(expectedOutput, sut)
    }

    func test_initViewModelWithLandingSuccessfulFalse_matchesExpectedOutput() throws {

        // GIVEN a `Launch` object where `landingSuccessful` is false
        let date = Date(timeIntervalSince1970: 1632409531)
        let url = try XCTUnwrap(URL(string: "https://spacex.com"))
        let numberFormatter = NumberFormatter.decimal

        let launch = Launch(name: "some launch",
                            launchDate: date,
                            landingSuccessful: false,
                            links: [],
                            patchImageUrl: url,
                            rocketName: "some rocket",
                            rocketType: "rocket")

        // WHEN a view model is initialised
        let sut = LaunchViewModel(launch, todaysDate: date, numberFormatter: numberFormatter)

        // THEN the `imageName` and `landingSuccessful` properties match our expectation
        let landingSuccessful = try XCTUnwrap(sut.landingSuccessful)
        XCTAssertFalse(landingSuccessful)
        XCTAssertEqual(sut.imageName, "cross-icon")
    }

    func test_initViewModelWithLandingSuccessfulNil_matchesExpectedOutput() throws {

        // GIVEN a `Launch` object where `landingSuccessful` is nil
        let date = Date(timeIntervalSince1970: 1632409531)
        let url = try XCTUnwrap(URL(string: "https://spacex.com"))
        let numberFormatter = NumberFormatter.decimal

        let launch = Launch(name: "some launch",
                            launchDate: date,
                            landingSuccessful: nil,
                            links: [],
                            patchImageUrl: url,
                            rocketName: "some rocket",
                            rocketType: "rocket")

        // WHEN a view model is initialised
        let sut = LaunchViewModel(launch, todaysDate: date, numberFormatter: numberFormatter)

        // THEN the `imageName` and `landingSuccessful` properties should be nil
        XCTAssertNil(sut.landingSuccessful)
        XCTAssertNil(sut.imageName)
    }

    // MARK: - Private Implementation Details
    private func createMockViewModel(date: Date, url: URL) -> LaunchViewModel {
        return LaunchViewModel(missionName: "some launch",
                               launchDateTime: "23/09/2021 at 03:05PM",
                               rocketInfo: "some rocket / rocket",
                               launchDate: date,
                               daysPlaceholder: "Days from:",
                               days: "0",
                               landingSuccessful: true,
                               imageName: "tick-icon",
                               links: [],
                               patchImageUrl: url)
    }
}
