import Localization
import Combine

protocol FilterViewModelDelegate: AnyObject {
    func dismiss()
}

final class FilterViewModel {

    // MARK: - Properties
    private let subject: FilterSubject
    private var year: Int?
    private var missionSuccessful: Bool?
    private var sortOrder: FilterCriteria.Order
    private weak var delegate: FilterViewModelDelegate?

    let selectedYear: Int
    let years: [String]
    let sortByPreference: Int
    let missionSuccessfulPreference: Int

    let sortByTitle: NSAttributedString
    let filterByYearTitle: NSAttributedString
    let missionSuccessfulTitle: NSAttributedString

    let noPreferenceLabelTitle = String(.noPreferenceLabel)
    let ascendingTitle = String(.ascendingTitle)
    let descendingTitle = String(.descendingTitle)
    let dismissTitle = String(.dismissTitle)
    let noLabelTitle = String(.noLabel)
    let pageTitle = String(.filterPageTitle)
    let yesLabelTitle = String(.yesLabel)

    // MARK: - Initialisers
    init(currentCriteria: FilterCriteria,
         subject: FilterSubject,
         years: [Int],
         typography: TypographyProvider,
         delegate: FilterViewModelDelegate? = nil) {

        self.delegate = delegate
        self.subject = subject
        self.sortByPreference = currentCriteria.order.rawValue
        self.missionSuccessfulPreference = Self.missionSuccessfulPreference(currentCriteria.missionSuccessful)
        self.year = currentCriteria.year
        self.missionSuccessful = currentCriteria.missionSuccessful
        self.sortOrder = currentCriteria.order

        filterByYearTitle = NSAttributedString(string: String(.filterByYearTitle),
                                               attributes: typography.filterHeading())

        missionSuccessfulTitle = NSAttributedString(string: String(.missionSuccessfulTitle),
                                                    attributes: typography.filterHeading())

        sortByTitle = NSAttributedString(string: String(.sortByTitle),
                                         attributes: typography.filterHeading())

        let years = [String(.allLabel)] + years.map(String.init)
        self.years = years

        if let year = currentCriteria.year.map(String.init),
           let selectedYearIndex = years.firstIndex(of: year) {
            selectedYear = Int(selectedYearIndex)
        } else {
            selectedYear = 0
        }
    }

    // MARK: - Public Facing API
    func dismiss() {

        subject.send(FilterCriteria(year: year,
                                    order: sortOrder,
                                    missionSuccessful: missionSuccessful))

        delegate?.dismiss()
    }

    func updateMissionSuccessfulPreference(_ index: Int) {

        if index == 0 {
            missionSuccessful = true
        } else if index == 1 {
            missionSuccessful = false
        } else {
            missionSuccessful = nil
        }
    }

    func updateSortOrder(_ index: Int) {
        sortOrder = index == 0 ? .ascending : .descending
    }

    func updateYearPreference(_ index: Int) {

        let selectedYear = years[index]
        let allYearsSelected = selectedYear == String(.allLabel)

        year = allYearsSelected ? nil : Int(selectedYear)
    }

    // MARK: - Private Implementation Details
    private static func missionSuccessfulPreference(_ missionPreference: Bool?) -> Int {

        if let missionPreference = missionPreference {
            return missionPreference ? 0 : 1
        }

        return 2
    }
}
