import UIKit

extension UINavigationController {

    func setRootOrShow(_ viewController: UIViewController,
                       sender: Any?,
                       animated: Bool = true) {

        if viewControllers.isEmpty {
            setViewControllers([viewController], animated: animated)
        } else {
            show(viewController, sender: sender)
        }
    }
}
