import Foundation

public enum LocalizedString: String, CaseIterable {
    case allLabel = "all.label"
    case articleLinkTitle = "article.link.title"
    case ascendingTitle = "ascending.title"
    case cancelTitle = "cancel.title"
    case companyDetailsInformation = "company.details.information"
    case companyTitle = "company.title"
    case dateTime = "date.time.title"
    case daysSince = "days.since.title"
    case daysFrom = "days.from.title"
    case descendingTitle = "descending.title"
    case dismissTitle = "dismiss.title"
    case filterByYearTitle = "filter.by.year.title"
    case filterPageTitle = "filter.page.title"
    case indexPageTitle = "index.page.title"
    case launchesTitle = "launches.title"
    case mission = "mission.title"
    case missionSuccessfulTitle = "mission.successful.title"
    case noLabel = "no.label"
    case noPreferenceLabel = "no.preference.label"
    case rocket = "rocket.title"
    case rocketDateTime = "rocket.date.time"
    case wikipediaLinkTitle = "wikipedia.link.title"
    case yesLabel = "yes.label"
    case youtubeLinkTitle = "youtube.link.title"
    case sortByTitle = "sort.by.title"
}

public extension String {

    init(_ localizedString: LocalizedString, bundle: Bundle = .main, comment: String = "") {
        self = NSLocalizedString(localizedString.rawValue, tableName: nil, bundle: bundle, value: "", comment: comment)
    }

    init(localizedWithParams: LocalizedString, params: CVarArg...) {
        self.init(String(format: String(localizedWithParams), locale: .current, arguments: params))
    }
}
