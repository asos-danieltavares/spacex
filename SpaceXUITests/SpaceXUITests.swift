import XCTest

final class SpaceXUITests: BaseTestCase {

    // MARK: - Tests
    func test_openFilterPage_tapDismiss_launchListPageIsShown() throws {

        // GIVEN a user navigates to the filter page
        let filterPage = try XCTUnwrap(navigator.goTo(screen: .filter) as? FilterPage)

        // WHEN the dismiss button is pressed
        let launchListPage = filterPage.tapDismiss()

        // THEN the launch list page is loaded
        XCTAssertTrue(launchListPage.pageIsLoaded)
    }

    func test_openLaunchListPage_tapLaunch_displaysOptionsPage() throws {

        // GIVEN a user navigates to the launch list page
        let launchListPage = try XCTUnwrap(navigator.goTo(screen: .launchList) as? LaunchListPage)

        // WHEN a launch is tapped
        let optionsPage = launchListPage.tapLaunch(index: 0)

        // THEN the option page loads
        XCTAssertTrue(optionsPage.pageIsLoaded)
    }
}
