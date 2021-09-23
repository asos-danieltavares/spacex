import XCTest

extension XCTestCase {

    func wait(for element: XCUIElement,
              toSatisfy predicate: NSPredicate,
              within duration: TimeInterval,
              continueAfterFailure: Bool) {

        expectation(for: predicate, evaluatedWith: element, handler: nil)

        let previousContinueAfterFailureValue = continueAfterFailure
        self.continueAfterFailure = continueAfterFailure

        waitForExpectations(timeout: duration) { error in
            if continueAfterFailure { return }

            if error != nil {
                self.record(.init(type: .uncaughtException, compactDescription: "Timed-out waiting for element"))
            }
        }

        self.continueAfterFailure = previousContinueAfterFailureValue
    }
}
