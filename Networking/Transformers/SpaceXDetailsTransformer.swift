import Models
import Localization

public struct SpaceXDetailsTransformer {

    // MARK: - Initialisers
    public init() { }

    // MARK: - Public Facing API
    public func transform(companyDetails: CompanyDetails,
                          launches: [LaunchResponse],
                          rockets: [Rocket]) -> SpaceXDetails? {

        let launchResults = launches.map { launch -> Launch in
            let rocket = rockets.first(where: { $0.identifier == launch.rocketId })
            let links = convertLinks(launch.links)

            return Launch(name: launch.name,
                          launchDate: launch.launchDate,
                          landingSuccessful: launch.landingSuccessful,
                          links: links,
                          patchImageUrl: launch.links.patch.small,
                          rocketName: rocket?.name,
                          rocketType: rocket?.type)
        }

        return SpaceXDetails(company: companyDetails, launches: launchResults)
    }

    // MARK: - Private Implementation Details
    private func convertLinks(_ links: LaunchResponse.Links) -> [Launch.Link] {

        var launchLinks: [Launch.Link] = []

        if let articleUrl = links.article {
            launchLinks.append(.init(name: String(.articleLinkTitle), url: articleUrl))
        }

        if let youtubeUrl = links.youtube {
            launchLinks.append(.init(name: String(.youtubeLinkTitle), url: youtubeUrl))
        }

        if let wikipediaUrl = links.wikipedia {
            launchLinks.append(.init(name: String(.wikipediaLinkTitle), url: wikipediaUrl))
        }

        return launchLinks
    }
}
