import XCTest
import Combine
@testable import SpaceX

final class FilterViewModelTests: XCTestCase {

    // MARK: - Properties
    private let typography = SpaceXTypography()
    private var filterSubject: FilterSubject!
    private var cancelBag: Set<AnyCancellable>!

    // MARK: - Overridden
    override func setUpWithError() throws {

        filterSubject = FilterSubject()
        cancelBag = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        filterSubject = nil
        cancelBag = nil
    }

    // MARK: - Tests
    func test_initViewModel_dismissCalled_delegateNotified() {

        // GIVEN an instance of FilterViewModel with a spy delegate
        let spyDelegate = SpyFilterViewModelDelegate()
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .ascending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [],
                                  typography: typography,
                                  delegate: spyDelegate)

        // WHEN dismiss is called
        sut.dismiss()

        // THEN the delegate is notified
        XCTAssertTrue(spyDelegate.dismissCalled)
    }

    func test_initViewModel_missionSuccessfulUpdatedToTrue_criteriaUpdated() {

        // GIVEN an instance of FilterViewModel
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .ascending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [],
                                  typography: typography)

        // WHEN missionSuccessful is updated
        sut.updateMissionSuccessfulPreference(0)

        // THEN the filterSubject has the expected value
        filterSubject.sink { criteria in
            let expectedOutput = FilterCriteria(year: nil, order: .ascending, missionSuccessful: true)
            XCTAssertEqual(criteria, expectedOutput)
        }
        .store(in: &cancelBag)

        sut.dismiss()
    }

    func test_initViewModel_missionSuccessfulUpdatedToFalse_criteriaUpdated() {

        // GIVEN an instance of FilterViewModel
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .ascending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [],
                                  typography: typography)

        // WHEN missionSuccessful is updated
        sut.updateMissionSuccessfulPreference(1)

        // THEN the filterSubject has the expected value
        filterSubject.sink { criteria in
            let expectedOutput = FilterCriteria(year: nil, order: .ascending, missionSuccessful: false)
            XCTAssertEqual(criteria, expectedOutput)
        }
        .store(in: &cancelBag)

        sut.dismiss()
    }

    func test_initViewModel_missionSuccessfulUpdatedToNoPreference_criteriaUpdated() {

        // GIVEN an instance of FilterViewModel
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .ascending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [],
                                  typography: typography)

        // WHEN missionSuccessful is updated
        sut.updateMissionSuccessfulPreference(2)

        // THEN the filterSubject has the expected value
        filterSubject.sink { criteria in
            let expectedOutput = FilterCriteria(year: nil, order: .ascending, missionSuccessful: nil)
            XCTAssertEqual(criteria, expectedOutput)
        }
        .store(in: &cancelBag)

        sut.dismiss()
    }

    func test_initViewModel_sortOrderUpdatedToAscending_criteriaUpdated() {

        // GIVEN an instance of FilterViewModel
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .descending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [],
                                  typography: typography)

        // WHEN sortOrder is updated to ascending
        sut.updateSortOrder(0)

        // THEN the filterSubject has the expected value
        filterSubject.sink { criteria in
            let expectedOutput = FilterCriteria(year: nil, order: .ascending, missionSuccessful: nil)
            XCTAssertEqual(criteria, expectedOutput)
        }
        .store(in: &cancelBag)

        sut.dismiss()
    }

    func test_initViewModel_sortOrderUpdatedToDescending_criteriaUpdated() {

        // GIVEN an instance of FilterViewModel
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .ascending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [],
                                  typography: typography)

        // WHEN sortOrder is updated to descending
        sut.updateSortOrder(1)

        // THEN the filterSubject has the expected value
        filterSubject.sink { criteria in
            let expectedOutput = FilterCriteria(year: nil, order: .descending, missionSuccessful: nil)
            XCTAssertEqual(criteria, expectedOutput)
        }
        .store(in: &cancelBag)

        sut.dismiss()
    }

    func test_initViewModel_yearUpdatedToParticularYear_criteriaUpdated() {

        // GIVEN an instance of FilterViewModel
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .ascending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [2020, 2021],
                                  typography: typography)

        // WHEN year is updated to the second index
        sut.updateYearPreference(1)

        // THEN the filterSubject has the expected value
        filterSubject.sink { criteria in
            let expectedOutput = FilterCriteria(year: 2020, order: .ascending, missionSuccessful: nil)
            XCTAssertEqual(criteria, expectedOutput)
        }
        .store(in: &cancelBag)

        sut.dismiss()
    }

    func test_initViewModel_yearUpdatedToAll_criteriaUpdated() {

        // GIVEN an instance of FilterViewModel
        let filterCriteria = FilterCriteria(year: nil,
                                            order: .ascending,
                                            missionSuccessful: nil)

        let sut = FilterViewModel(currentCriteria: filterCriteria,
                                  subject: filterSubject,
                                  years: [2020, 2021],
                                  typography: typography)

        // WHEN year is updated to the second index
        sut.updateYearPreference(0)

        // THEN the filterSubject has the expected value
        filterSubject.sink { criteria in
            let expectedOutput = FilterCriteria(year: nil, order: .ascending, missionSuccessful: nil)
            XCTAssertEqual(criteria, expectedOutput)
        }
        .store(in: &cancelBag)

        sut.dismiss()
    }
}
