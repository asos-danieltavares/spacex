import Foundation

public struct Rocket: Decodable {

    // MARK: - Properties
    public let name: String
    public let identifier: String
    public let type: String

    // MARK: - Initialisers
    public init(name: String, identifier: String, type: String) {
        self.name = name
        self.identifier = identifier
        self.type = type
    }

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case name
        case identifier = "id"
        case type
    }
}
