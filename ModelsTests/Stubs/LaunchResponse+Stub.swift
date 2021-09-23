import Models

extension LaunchResponse {

    static func stub(name: String, date: Date) -> Self {

        let links = Links(article: nil,
                          youtube: nil,
                          wikipedia: nil,
                          patch: .init(small: nil, large: nil))

        return LaunchResponse(name: name,
                              launchDate: date,
                              landingSuccessful: true,
                              links: links,
                              rocketId: "12345")
    }
}
