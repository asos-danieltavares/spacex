import Localization
import Models
import Networking
import Combine

typealias FilterSubject = PassthroughSubject<FilterCriteria, Never>

struct FilterCriteria: Equatable {
    let year: Int?
    let order: Order
    let missionSuccessful: Bool?

    enum Order: Int {
        case ascending
        case descending
    }
}

protocol IndexViewModelDelegate: AnyObject {
    func launchSelected(_ launchName: String, links: [Launch.Link])
    func filterSelected(_ subject: FilterSubject, currentCriteria: FilterCriteria, years: [Int])
}

final class IndexViewModel {

    // MARK: - Properties
    private let typography: TypographyProvider
    private let filterUpdated = FilterSubject()
    private let networkService: NetworkService
    private var cancelBag = Set<AnyCancellable>()
    private var cancellable: AnyCancellable?
    private var viewModels: [LaunchViewModel] = []
    private var years: [Int] = []
    private weak var delegate: IndexViewModelDelegate?

    var headerViewModel: HeaderViewModel?
    var filterCriteria: FilterCriteria = .init(year: nil,
                                               order: .ascending,
                                               missionSuccessful: nil)

    let pageTitle: String

    @Published var state: State = .loading

    // MARK: - Initialisers
    init(networkService: NetworkService,
         typography: TypographyProvider,
         delegate: IndexViewModelDelegate? = nil) {
        self.pageTitle = String(.indexPageTitle)
        self.networkService = networkService
        self.delegate = delegate
        self.typography = typography
        self.headerViewModel = nil

        configureFilterSubscription()
    }

    // MARK: - Public Facing API
    func fetchDetails() {

        let todaysDate = Date()

        let apiResponse = networkService.fetchSpaceXDetails()
            .handleEvents(receiveOutput: { [weak self] response in
                let companyViewModel = CompanyViewModel(companyDetails: response.company,
                                                        numberFormatter: .decimal)
                self?.headerViewModel = HeaderViewModel(companyInformation: companyViewModel.companyInformation)
            })
            .tryMap { details -> [LaunchViewModel] in
                return details.launches.map { launch in
                    LaunchViewModel(launch,
                                    todaysDate: todaysDate,
                                    numberFormatter: .decimal)
                }
            }
            .eraseToAnyPublisher()

        cancellable = apiResponse
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .sink { [weak self] viewModels in
                self?.viewModels = viewModels
                self?.state = viewModels.isEmpty ? .error : .loaded(viewModels)

                self?.years = viewModels.map {
                    Calendar.current.component(.year, from: $0.launchDate)
                }.unique()
            }
    }

    func launchSelected(_ viewModel: LaunchViewModel) {
        delegate?.launchSelected(viewModel.missionName, links: viewModel.links)
    }

    func filterSelected() {
        delegate?.filterSelected(filterUpdated, currentCriteria: filterCriteria, years: years)
    }

    // MARK: - Private Implementation Details
    private func configureFilterSubscription() {

        filterUpdated
            .sink { [weak self] criteria in
                guard let self = self else { return }

                let viewModels = self.viewModels
                    .filterByYear(criteria.year)
                    .filterByMissionSuccessful(criteria.missionSuccessful)
                    .orderBy(criteria.order)

                self.filterCriteria = criteria
                self.state = .reload(viewModels)

            }.store(in: &cancelBag)
    }
}

// MARK: - Data Structures
extension IndexViewModel {

    enum State: Equatable {
        case loading
        case loaded([LaunchViewModel])
        case error
        case reload([LaunchViewModel])
    }
}

private extension Array where Element == LaunchViewModel {

    func filterByYear(_ year: Int?) -> [Element] {
        guard let year = year else { return self }

        return filter {
            let launchYear = Calendar.current.component(.year, from: $0.launchDate)
            return launchYear == year
        }
    }

    func filterByMissionSuccessful(_ landingSuccessful: Bool?) -> [Element] {
        guard let landingSuccessful = landingSuccessful else { return self }

        return filter { $0.landingSuccessful == landingSuccessful }
    }

    func orderBy(_ order: FilterCriteria.Order) -> [Element] {
        switch order {
        case .ascending:
            return sorted(by: { $0.launchDate < $1.launchDate })
        case .descending:
            return sorted(by: { $0.launchDate > $1.launchDate })
        }
    }
}
