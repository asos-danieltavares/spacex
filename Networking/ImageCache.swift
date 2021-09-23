import UIKit

public protocol ImageCachable {
    func get(key: URL) -> UIImage?
    func set(key: URL, image: UIImage)
}

public final class ImageCache: ImageCachable {

    // MARK: - Properties
    private let cache = NSCache<NSURL, UIImage>()

    // MARK: - Initialisers
    public init() { }

    // MARK: - Public Facing API
    public func get(key: URL) -> UIImage? {
        cache.object(forKey: key as NSURL)
    }

    public func set(key: URL, image: UIImage) {
        cache.setObject(image, forKey: key as NSURL)
    }
}
