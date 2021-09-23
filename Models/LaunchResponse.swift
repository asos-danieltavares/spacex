import Foundation

public struct LaunchResponse: Decodable {

    // MARK: - Properties
    public let name: String
    public let launchDate: Date
    public let landingSuccessful: Bool?
    public let links: Links
    public let rocketId: String

    // MARK: - Initialisers
    public init(name: String,
                launchDate: Date,
                landingSuccessful: Bool?,
                links: Links,
                rocketId: String) {
        self.name = name
        self.launchDate = launchDate
        self.landingSuccessful = landingSuccessful
        self.links = links
        self.rocketId = rocketId
    }

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case name
        case launchDate = "dateUnix"
        case landingSuccessful = "success"
        case links
        case rocketId = "rocket"
    }

    // MARK: - Data Structures
    public struct Links: Decodable {
        public let article: URL?
        public let youtube: URL?
        public let wikipedia: URL?
        public let patch: Patch

        public init(article: URL?,
                    youtube: URL?,
                    wikipedia: URL?,
                    patch: Patch) {
            self.article = article
            self.youtube = youtube
            self.wikipedia = wikipedia
            self.patch = patch
        }

        private enum CodingKeys: String, CodingKey {
            case article
            case youtube = "webcast"
            case wikipedia
            case patch
        }
    }

    public struct Patch: Decodable {
        public let small: URL?
        public let large: URL?

        public init(small: URL?, large: URL?) {
            self.small = small
            self.large = large
        }
    }
}
