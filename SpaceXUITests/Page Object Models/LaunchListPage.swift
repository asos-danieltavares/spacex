import XCTest

final class LaunchListPage: BasePage {

    // MARK: - Properties
    override var pageIsLoaded: Bool {
        falconSatMissionLabel.waitForExistance(in: testCase)
        return falconSatMissionLabel.exists
    }

    private var falconSatMissionLabel: XCUIElement {
        app.staticTexts["FalconSat"]
    }

    private var collectionView: XCUIElement {
        app.collectionViews.firstMatch
    }

    private var filterButton: XCUIElement {
        app.buttons.firstMatch
    }

    // MARK: - Initialisers
    required init(app: XCUIApplication, testCase: BaseTestCase) {
        super.init(app: app, testCase: testCase)
    }

    // MARK: - Public Facing API
    func tapFilter() -> FilterPage {
        filterButton.tap()
        return FilterPage(app: app, testCase: testCase)
    }

    func tapLaunch(index: Int) -> OptionsPage {
        collectionView.cells.element(boundBy: index).tap()
        return OptionsPage(app: app, testCase: testCase)
    }
}
