import UIKit
import Combine

public protocol ImageLoadable: AnyObject {
    func loadImage(for url: URL) -> AnyPublisher<UIImage, Error>
}

public final class ImageLoader: ImageLoadable {

    // MARK: - Properties
    private let urlSession: URLSession
    private let cache: ImageCachable

    // MARK: - Initialisers
    public init(urlSession: URLSession = .shared,
                cache: ImageCachable = ImageCache()) {
        self.urlSession = urlSession
        self.cache = cache
    }

    public func loadImage(for url: URL) -> AnyPublisher<UIImage, Error> {

        if let image = cache.get(key: url) {
            return Just(image)
                .setFailureType(to: Error.self)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }

                return image
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [cache] image in
                cache.set(key: url, image: image)
            })
            .eraseToAnyPublisher()
    }
}
