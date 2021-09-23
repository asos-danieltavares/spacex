import Networking
import Models

final class StubAPIClient: APIClient {

    // MARK: - Properties
    private let stubResourceForCompanyDetails = StubResourceLoader(requestType: .companyDetails)
    private let stubResourceForLaunches = StubResourceLoader(requestType: .launches)
    private let stubResourceForRockets = StubResourceLoader(requestType: .rockets)
    private let jsonDecoder = JSONDecoder()
    private let stubUrl = URL(string: "https://api.spacexdata.com/")!

    // MARK: - Public Facing API
    func fetchCompanyDetails() -> CompanyDetailsResponse {
        stubResourceForCompanyDetails.fetchResource(forUrl: stubUrl,
                                                    decodingType: CompanyDetails.self,
                                                    jsonDecoder: jsonDecoder,
                                                    retryCount: 1)
    }

    func fetchLaunches() -> LaunchesResponse {
        stubResourceForLaunches.fetchResource(forUrl: stubUrl,
                                              decodingType: [LaunchResponse].self,
                                              jsonDecoder: jsonDecoder,
                                              retryCount: 1)
    }

    func fetchRockets() -> RocketsResponse {
        stubResourceForRockets.fetchResource(forUrl: stubUrl,
                                             decodingType: [Rocket].self,
                                             jsonDecoder: jsonDecoder,
                                             retryCount: 1)
    }
}
