import XCTest

extension XCUIElement {

    func waitForExistance(in testCase: XCTestCase, with timeout: TimeInterval = 5.0) {

        testCase.wait(for: self,
                      toSatisfy: NSPredicate(format: "exists == True"),
                      within: timeout,
                      continueAfterFailure: true)
    }
}
