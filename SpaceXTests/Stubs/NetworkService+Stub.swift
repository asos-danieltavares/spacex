import Networking
import Models
import Combine

struct StubNetworkService: NetworkService {

    enum NetworkError: Error {
        case stubError
    }

    func fetchSpaceXDetails() -> AnyPublisher<SpaceXDetails, Error> {

        let companyDetails = CompanyDetails.stub(name: "Some company")
        let details = SpaceXDetails(company: companyDetails,
                                    launches: [
                                        Launch.stub(name: "some launch", date: Date())
                                    ])

        return Just(details)
            .mapError { _ in NetworkError.stubError }
            .eraseToAnyPublisher()
    }
}
