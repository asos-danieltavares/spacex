import XCTest
import Models
import Combine
@testable import SpaceX

final class IndexViewModelTests: XCTestCase {

    // MARK: - Properties
    private let typography = SpaceXTypography()
    private var cancelBag: Set<AnyCancellable>!

    // MARK: - Overridden
    override func setUpWithError() throws {
        cancelBag = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        cancelBag = nil
    }

    // MARK: - Tests
    func test_initViewModelWithSpyDelegate_launchSelected_delegateNotified() {

        // GIVEN an instance of IndexViewModel with a spy delegate
        let spyDelegate = SpyIndexViewModelDelegate()
        let networkService = StubNetworkService()

        let sut = IndexViewModel(networkService: networkService,
                                 typography: typography,
                                 delegate: spyDelegate)

        // WHEN the `launchSelected` method is called
        let launchStub = Launch.stub(name: "some launch", date: Date())

        sut.launchSelected(LaunchViewModel(launchStub,
                                           todaysDate: Date(),
                                           numberFormatter: .decimal))

        // THEN the delegate is notified
        XCTAssertTrue(spyDelegate.launchSelected)
    }

    func test_initViewModelWithSpyDelegate_filterSelected_delegateNotified() {

        // GIVEN an instance of IndexViewModel with a spy delegate
        let spyDelegate = SpyIndexViewModelDelegate()
        let networkService = StubNetworkService()

        let sut = IndexViewModel(networkService: networkService,
                                 typography: typography,
                                 delegate: spyDelegate)

        // WHEN the `filterSelected` method is called
        sut.filterSelected()

        // THEN the delegate is notified
        XCTAssertTrue(spyDelegate.filterSelected)
    }

    func test_initViewModel_fetchDetails_viewModelsUpdated() {

        let expectation = self.expectation(description: "Awaiting response")

        // GIVEN an instance of IndexViewModel with a stub network service
        let networkService = StubNetworkService()
        let sut = IndexViewModel(networkService: networkService, typography: typography, delegate: nil)

        // WHEN fetchDetails is called
        var stateCount: Int = 0

        sut.$state.sink { state in

            // THEN view models are loaded
            if stateCount == 1 {
                guard case let .loaded(viewModels) = state else {
                    XCTFail("Expecting view models returned")
                    return
                }

                XCTAssertEqual(viewModels.count, 1)
            }

            stateCount += 1

            if stateCount == 2 {
                expectation.fulfill()
            }

        }.store(in: &cancelBag)

        sut.fetchDetails()

        wait(for: [expectation], timeout: 5.0)
    }
}
