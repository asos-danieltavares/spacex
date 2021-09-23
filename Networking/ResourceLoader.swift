import Foundation
import Combine

public protocol ResourceLoadable {
    func fetchResource<T: Decodable>(forUrl url: URL,
                                     decodingType: T.Type,
                                     jsonDecoder: JSONDecoder,
                                     retryCount: Int) -> AnyPublisher<T, Error>
}

public final class ResourceLoader: ResourceLoadable {

    // MARK: - Properties
    private let session: URLSession

    // MARK: - Initialisers
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    // MARK: - Public Facing API
    public func fetchResource<T: Decodable>(forUrl url: URL,
                                            decodingType: T.Type,
                                            jsonDecoder: JSONDecoder = JSONDecoder(),
                                            retryCount: Int = 1) -> AnyPublisher<T, Error> {

        session.dataTaskPublisher(for: url)
            .retry(retryCount)
            .tryMap(\.data)
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
