import Networking
import Localization
import Models
import SafariServices
import Combine

protocol LaunchURLDelegate {
    func didTapUrl(_ url: URL)
}

typealias Delegate = IndexViewModelDelegate & LaunchURLDelegate & FilterViewModelDelegate

struct ViewControllerFactory {

    // MARK: - Properties
    let theming: ThemingProvider
    let typography: TypographyProvider
    let networkService: NetworkService
    let imageLoader: ImageLoadable

    // MARK: - Public Facing API
    func viewController(forScreen screen: Screen,
                        delegate: Delegate?) -> UIViewController {

        switch screen {
        case .index:
            return createIndexPage(delegate: delegate)
        case let .links(missionName, links):
            return createLinksPage(title: missionName, links: links, delegate: delegate)
        case let .filterOptions(subject, criteria, years):
            return createFilterPage(subject, criteria: criteria, years: years, delegate: delegate)
        case .safariWebview(let url):
            return SFSafariViewController(url: url)
        }
    }

    // MARK: - Private Implementation Details
    private func createIndexPage(delegate: IndexViewModelDelegate?) -> UIViewController {
        let viewModel = IndexViewModel(networkService: networkService,
                                       typography: typography,
                                       delegate: delegate)
        return IndexViewController(viewModel: viewModel,
                                   theming: theming,
                                   imageLoader: imageLoader)
    }

    private func createLinksPage(title: String,
                                 links: [Launch.Link],
                                 delegate: Delegate?) -> UIViewController {

        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)

        links.forEach { link in
            alertController.addAction(.init(title: link.name, style: .default) { _ in
                delegate?.didTapUrl(link.url)
            })
        }

        alertController.addAction(.init(title: String(.cancelTitle), style: .cancel, handler: nil))

        return alertController
    }

    private func createFilterPage(_ subject: FilterSubject,
                                  criteria: FilterCriteria,
                                  years: [Int],
                                  delegate: Delegate?) -> UIViewController {

        let viewModel = FilterViewModel(currentCriteria: criteria,
                                        subject: subject,
                                        years: years,
                                        typography: typography,
                                        delegate: delegate)

        let viewController = FilterViewController(viewModel: viewModel,
                                                  theming: theming)

        let navigationController = UINavigationController()
        navigationController.setRootOrShow(viewController, sender: self)
        return navigationController
    }
}
