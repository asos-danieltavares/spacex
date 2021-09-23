import UIKit
import Networking

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    internal var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: scene)

        let transformer = SpaceXDetailsTransformer()
        let apiClient = SpaceXAPIClient()
        let networkService = SpaceXNetworkService(apiClient: apiClient, transformer: transformer)
        let theming = SpaceXTheming()
        let imageLoader = ImageLoader()
        let typography = SpaceXTypography()

        let viewControllerFactory = ViewControllerFactory(theming: theming,
                                                          typography: typography,
                                                          networkService: networkService,
                                                          imageLoader: imageLoader)
        let navigationController = UINavigationController()

        appCoordinator = AppCoordinator(.init(navigationController: navigationController,
                                              viewControllerFactory: viewControllerFactory))
        appCoordinator?.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
