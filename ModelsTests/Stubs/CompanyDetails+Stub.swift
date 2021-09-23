import Models

extension CompanyDetails {

    static func stub(name: String) -> Self {
        Self(name: name,
             founder: "Joe Bloggs",
             founded: 2000,
             employees: 1000,
             launchSites: 50,
             valuation: 1_000_000_000)
    }
}
