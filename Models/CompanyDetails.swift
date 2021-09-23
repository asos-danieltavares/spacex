import Foundation

public struct CompanyDetails: Decodable, Equatable {

    // MARK: - Properties
    public let name: String
    public let founder: String
    public let founded: Int
    public let employees: Int
    public let launchSites: Int
    public let valuation: Double

    // MARK: - Initialisers
    public init(name: String,
                founder: String,
                founded: Int,
                employees: Int,
                launchSites: Int,
                valuation: Double) {
        self.name = name
        self.founder = founder
        self.founded = founded
        self.employees = employees
        self.launchSites = launchSites
        self.valuation = valuation
    }
}
