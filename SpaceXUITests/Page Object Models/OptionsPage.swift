import XCTest

final class OptionsPage: BasePage {

    // MARK: - Properties
    override var pageIsLoaded: Bool {
        cancelButton.waitForExistance(in: testCase)
        return cancelButton.exists
    }

    private var cancelButton: XCUIElement {
        app.buttons["Cancel"]
    }

    // MARK: - Initialisers
    required init(app: XCUIApplication, testCase: BaseTestCase) {
        super.init(app: app, testCase: testCase)
    }

    // MARK: - Public Facing API
}
