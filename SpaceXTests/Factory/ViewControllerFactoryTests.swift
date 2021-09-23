import XCTest
import Networking
import SafariServices
import Combine
@testable import SpaceX

final class ViewControllerFactoryTests: XCTestCase {

    // MARK: - Properties
    private let theming = SpaceXTheming()
    private let typography = SpaceXTypography()
    private let networkService = StubNetworkService()
    private let stubImageLoader = StubImageLoader()

    // MARK: - Tests
    func test_initFactory_fetchScreenForIndex_returnsExpectedResult() {

        // GIVEN an instance of ViewControllerFactory
        let sut = ViewControllerFactory(theming: theming,
                                        typography: typography,
                                        networkService: networkService,
                                        imageLoader: stubImageLoader)

        // WHEN a viewController is requested for the `index` screen
        let viewController = sut.viewController(forScreen: .index, delegate: nil)

        // THEN the viewController is of type `IndexViewController`
        XCTAssertTrue(viewController is IndexViewController)
    }

    func test_initFactory_fetchScreenForLinks_returnsExpectedResult() {

        // GIVEN an instance of ViewControllerFactory
        let sut = ViewControllerFactory(theming: theming,
                                        typography: typography,
                                        networkService: networkService,
                                        imageLoader: stubImageLoader)

        // WHEN a viewController is requested for the `links` screen
        let viewController = sut.viewController(forScreen: .links(name: "Some link", links: []), delegate: nil)

        // THEN the viewController is of type `UIAlertController`
        XCTAssertTrue(viewController is UIAlertController)
    }

    func test_initFactory_fetchScreenForUrl_returnsExpectedResult() throws {

        // GIVEN an instance of ViewControllerFactory
        let sut = ViewControllerFactory(theming: theming,
                                        typography: typography,
                                        networkService: networkService,
                                        imageLoader: stubImageLoader)

        // WHEN a viewController is requested for the `links` screen
        let url = try XCTUnwrap(URL(string: "https://www.google.co.uk"))
        let viewController = sut.viewController(forScreen: .safariWebview(url), delegate: nil)

        // THEN the viewController is of type `SFSafariViewController`
        XCTAssertTrue(viewController is SFSafariViewController)
    }

    func test_initFactory_fetchScreenForFilter_returnsExpectedResult() throws {

        // GIVEN an instance of ViewControllerFactory
        let sut = ViewControllerFactory(theming: theming,
                                        typography: typography,
                                        networkService: networkService,
                                        imageLoader: stubImageLoader)

        // WHEN a viewController is requested for the `filter` screen
        let subject = FilterSubject()
        let years: [Int] = []
        let filterCriteria = FilterCriteria(year: nil, order: .ascending, missionSuccessful: nil)

        let viewController = sut.viewController(forScreen: .filterOptions(subject: subject, criteria: filterCriteria, years: years), delegate: nil)

        // THEN the viewController is of type `FilterViewController`
        let navigationController = try XCTUnwrap(viewController as? UINavigationController)

        XCTAssertTrue(navigationController.viewControllers.first is FilterViewController)
    }
}
