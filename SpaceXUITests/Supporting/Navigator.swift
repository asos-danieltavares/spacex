import XCTest

final class Navigator {

    // MARK: - Properties
    private let app: XCUIApplication
    private let testCase: BaseTestCase

    // MARK: - Initialisers
    init(app: XCUIApplication, testCase: BaseTestCase) {
        self.app = app
        self.testCase = testCase
    }

    // MARK: - Public Facing API
    func goTo(screen: Screen) -> BasePage {

        switch screen {
        case .launchList: return goToLaunchList()
        case .filter: return goToFilterPage()
        case .options(let index): return goToOptionsPage(index: index)
        }
    }
}

// MARK: - Private Implementation Details
private extension Navigator {

    func goToLaunchList() -> LaunchListPage {
        LaunchListPage(app: app, testCase: testCase)
    }

    func goToFilterPage() -> FilterPage {
        let launchListPage = goToLaunchList()
        return launchListPage.tapFilter()
    }

    func goToOptionsPage(index: Int) -> OptionsPage {
        let launchListPage = goToLaunchList()
        return launchListPage.tapLaunch(index: index)
    }
}
