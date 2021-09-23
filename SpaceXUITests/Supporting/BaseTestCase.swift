import XCTest

class BaseTestCase: XCTestCase {

    // MARK: - Properties
    var app: XCUIApplication!
    var navigator: Navigator!

    // MARK: - Overridden
    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()

        self.app = app
        self.navigator = Navigator(app: app, testCase: self)
    }

    override func tearDownWithError() throws {
        app = nil
        navigator = nil

        try super.tearDownWithError()
    }
}
