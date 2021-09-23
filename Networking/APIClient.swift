import Combine
import Models

public typealias CompanyDetailsResponse = AnyPublisher<CompanyDetails, Error>
public typealias LaunchesResponse = AnyPublisher<[LaunchResponse], Error>
public typealias RocketsResponse = AnyPublisher<[Rocket], Error>

public protocol APIClient {
    func fetchCompanyDetails() -> CompanyDetailsResponse
    func fetchLaunches() -> LaunchesResponse
    func fetchRockets() -> RocketsResponse
}

public final class SpaceXAPIClient: APIClient {

    // MARK: - Properties
    private let resourceLoader: ResourceLoadable
    private let jsonDecoder: JSONDecoder

    // MARK: - Initialisers
    public init(resourceLoader: ResourceLoadable = ResourceLoader(session: .shared)) {
        self.resourceLoader = resourceLoader

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .secondsSince1970

        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Public Facing API
    public func fetchCompanyDetails() -> CompanyDetailsResponse {

        resourceLoader.fetchResource(forUrl: EndpointPath.companyDetails.url,
                                     decodingType: CompanyDetails.self,
                                     jsonDecoder: jsonDecoder,
                                     retryCount: 1)
    }

    public func fetchLaunches() -> LaunchesResponse {

        resourceLoader.fetchResource(forUrl: EndpointPath.launches.url,
                                     decodingType: [LaunchResponse].self,
                                     jsonDecoder: jsonDecoder,
                                     retryCount: 1)
    }

    public func fetchRockets() -> RocketsResponse {

        resourceLoader.fetchResource(forUrl: EndpointPath.rockets.url,
                                     decodingType: [Rocket].self,
                                     jsonDecoder: jsonDecoder,
                                     retryCount: 1)
    }

    // MARK: - Private Implementation Details
    internal enum EndpointPath: String, CaseIterable {
        case companyDetails = "/v4/company"
        case launches = "/v4/launches"
        case rockets = "/v4/rockets"

        var url: URL {
            Endpoint(path: rawValue).url!
        }
    }
}
