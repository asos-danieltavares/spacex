import Foundation

public struct SpaceXDetails: Equatable {

    // MARK: - Properties
    public let company: CompanyDetails
    public let launches: [Launch]

    // MARK: - Initialisers
    public init(company: CompanyDetails, launches: [Launch]) {
        self.company = company
        self.launches = launches
    }
}
