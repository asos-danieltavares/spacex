import XCTest

class BasePage {

    // MARK: - Properties
    let app: XCUIApplication
    let testCase: BaseTestCase

    var timeoutPeriod: Double {
        15.0
    }

    var pageIsLoaded: Bool {
        false
    }

    // MARK: - Initialisers
    required init(app: XCUIApplication, testCase: BaseTestCase) {
        self.app = app
        self.testCase = testCase
    }
}
