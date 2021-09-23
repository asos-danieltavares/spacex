import Models

extension Rocket {

    static func stub(name: String) -> Self {
        return Self(name: name, identifier: "12345", type: "rocket")
    }
}
