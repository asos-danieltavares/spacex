@testable import SpaceX
import Models

final class SpyIndexViewModelDelegate: IndexViewModelDelegate {

    var launchSelected = false
    var filterSelected = false

    func launchSelected(_ launchName: String, links: [Launch.Link]) {
        launchSelected = true
    }

    func filterSelected(_ subject: FilterSubject,
                        currentCriteria: FilterCriteria,
                        years: [Int]) {
        filterSelected = true
    }
}
