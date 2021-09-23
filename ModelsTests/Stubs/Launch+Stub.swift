import Models

extension Launch {

    static func stub(name: String, date: Date) -> Self {
        return Self(name: name,
                    launchDate: date,
                    landingSuccessful: true,
                    links: [],
                    patchImageUrl: nil,
                    rocketName: "some-rocket",
                    rocketType: "rocket")
    }
}
