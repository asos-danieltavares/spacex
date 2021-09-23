import Combine
import Models

public protocol NetworkService {
    func fetchSpaceXDetails() -> AnyPublisher<SpaceXDetails, Error>
}

public final class SpaceXNetworkService: NetworkService {

    // MARK: - Properties
    private let apiClient: APIClient
    private let transformer: SpaceXDetailsTransformer

    // MARK: - Initialisers
    public init(apiClient: APIClient, transformer: SpaceXDetailsTransformer) {
        self.apiClient = apiClient
        self.transformer = transformer
    }

    // MARK: - Public Facing API
    public func fetchSpaceXDetails() -> AnyPublisher<SpaceXDetails, Error> {

        Publishers.Zip3(
            apiClient.fetchCompanyDetails(),
            apiClient.fetchLaunches(),
            apiClient.fetchRockets()
        )
        .tryCompactMap(transformer.transform)
        .eraseToAnyPublisher()
    }
}
