import UIKit
import Models
import Combine

final class AppCoordinator: Coordinator {

    // MARK: - Properties
    private let dependencies: Dependencies

    // MARK: - Initialisers
    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Public Facing API
    func start() {
        navigate(to: .index)
    }

    // MARK: - Private Implementation Details
    private func navigate(to screen: Screen, presented: Bool = false) {

        let viewController = dependencies.viewControllerFactory.viewController(forScreen: screen, delegate: self)
        let navigationController = dependencies.navigationController

        if presented {
            navigationController.present(viewController, animated: true, completion: nil)
        } else {
            navigationController.setRootOrShow(viewController, sender: self)
        }
    }
}

// MARK: - IndexViewModelDelegate, LaunchURLDelegate & FilterViewModelDelegate
extension AppCoordinator: IndexViewModelDelegate, LaunchURLDelegate, FilterViewModelDelegate {

    func launchSelected(_ launchName: String, links: [Launch.Link]) {
        navigate(to: .links(name: launchName, links: links), presented: true)
    }

    func filterSelected(_ subject: FilterSubject, currentCriteria: FilterCriteria, years: [Int]) {
        navigate(to: .filterOptions(subject: subject, criteria: currentCriteria, years: years),
                 presented: true)
    }

    func didTapUrl(_ url: URL) {
        navigate(to: .safariWebview(url), presented: true)
    }

    func dismiss() {
        dependencies.navigationController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Data Structures
extension AppCoordinator {

    struct Dependencies {
        let navigationController: UINavigationController
        let viewControllerFactory: ViewControllerFactory
    }
}
