import XCTest

final class FilterPage: BasePage {

    // MARK: - Properties
    override var pageIsLoaded: Bool {
        sortByLabel.waitForExistance(in: testCase)
        return sortByLabel.exists
    }

    private var sortByLabel: XCUIElement {
        app.staticTexts["Sort by:"]
    }

    private var dismissButton: XCUIElement {
        app.buttons["Dismiss"]
    }

    // MARK: - Initialisers
    required init(app: XCUIApplication, testCase: BaseTestCase) {
        super.init(app: app, testCase: testCase)
    }

    // MARK: - Public Facing API
    func tapDismiss() -> LaunchListPage {
        dismissButton.tap()
        return LaunchListPage(app: app, testCase: testCase)
    }
}
