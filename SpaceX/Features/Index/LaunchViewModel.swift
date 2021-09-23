import Models
import Localization

struct LaunchViewModel: Hashable {
    let missionName: String
    let launchDateTime: String
    let rocketInfo: String
    let launchDate: Date
    let daysPlaceholder: String
    let days: String
    let landingSuccessful: Bool?
    let imageName: String?
    let links: [Launch.Link]
    let patchImageUrl: URL?
}

extension LaunchViewModel {

    init(_ launch: Launch,
         todaysDate: Date,
         numberFormatter: NumberFormatter) {

        missionName = launch.name
        launchDate = launch.launchDate
        links = launch.links
        rocketInfo = "\(launch.rocketName.orEmpty()) / \(launch.rocketType.orEmpty())"

        let launchDate = launch.launchDate
        let day = launchDate.days(betweenDate: todaysDate)

        launchDateTime = String(localizedWithParams: .rocketDateTime, params: launchDate.dayMonthYear(), launchDate.hourMinutes())

        daysPlaceholder = launchDate < todaysDate ? String(.daysSince) : String(.daysFrom)
        days = numberFormatter.string(from: NSNumber(value: day)) ?? ""

        patchImageUrl = launch.patchImageUrl

        landingSuccessful = launch.landingSuccessful

        if let successfulLaunch = launch.landingSuccessful {
            imageName = successfulLaunch ? "tick-icon" : "cross-icon"
        } else {
            imageName = nil
        }
    }
}
