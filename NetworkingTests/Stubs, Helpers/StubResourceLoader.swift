import Models
import Combine
@testable import Networking

struct StubResourceLoader: ResourceLoadable {

    // MARK: - Properties
    let requestType: Request

    // MARK: - Public Facing API
    func fetchResource<T: Decodable>(forUrl url: URL,
                                     decodingType: T.Type,
                                     jsonDecoder: JSONDecoder,
                                     retryCount: Int) -> AnyPublisher<T, Error> {

        // swiftlint:disable:next force_cast
        return Just(getStub() as! T)
            .mapError { _ in NetworkError.stubError }
            .eraseToAnyPublisher()
    }

    private func getStub() -> Decodable {

        switch requestType {
        case .rockets:
            return [
                Rocket(name: "Falcon", identifier: "falcon", type: "rocket")
            ]
        case .launches:

            let patch = LaunchResponse.Patch(small: nil, large: nil)
            let links = LaunchResponse.Links(article: nil, youtube: nil, wikipedia: nil, patch: patch)

            return [
                LaunchResponse(name: "some launch",
                               launchDate: Date(),
                               landingSuccessful: true,
                               links: links,
                               rocketId: "12345")
            ]
        case .companyDetails:
            return CompanyDetails(name: "SpaceX",
                                  founder: "Joe Bloggs",
                                  founded: 2000,
                                  employees: 200,
                                  launchSites: 50,
                                  valuation: 1_000_000_000_000)
        }
    }
}

// MARK: - Data Structures
extension StubResourceLoader {

    enum NetworkError: Error {
        case stubError
    }

    enum Request {
        case rockets
        case launches
        case companyDetails
    }
}
