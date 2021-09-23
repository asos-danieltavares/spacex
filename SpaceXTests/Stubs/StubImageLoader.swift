import UIKit
import Combine
import Networking
@testable import SpaceX

final class StubImageLoader: ImageLoadable {

    // MARK: - Data Structures
    private enum StubError: Error {
        case failedToLoadImage
    }

    // MARK: - Public Facing API
    func loadImage(for url: URL) -> AnyPublisher<UIImage, Error> {

        let bundle = Bundle(for: type(of: self))

        let image = UIImage(named: "falcon-demo.png", in: bundle, compatibleWith: nil)!

        return Just(image)
            .mapError { _ in StubError.failedToLoadImage }
            .eraseToAnyPublisher()
    }
}
