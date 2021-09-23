import Foundation

public struct Launch: Equatable {

    // MARK: - Properties
    public let name: String
    public let launchDate: Date
    public let landingSuccessful: Bool?
    public let links: [Link]
    public let patchImageUrl: URL?
    public let rocketName: String?
    public let rocketType: String?

    // MARK: - Initialisers
    public init(name: String,
                launchDate: Date,
                landingSuccessful: Bool?,
                links: [Link],
                patchImageUrl: URL?,
                rocketName: String?,
                rocketType: String?) {

        self.name = name
        self.launchDate = launchDate
        self.landingSuccessful = landingSuccessful
        self.links = links
        self.patchImageUrl = patchImageUrl
        self.rocketName = rocketName
        self.rocketType = rocketType
    }

    // MARK: - Data Structures
    public struct Link: Hashable {
        public let name: String
        public let url: URL

        public init(name: String, url: URL) {
            self.name = name
            self.url = url
        }
    }
}
