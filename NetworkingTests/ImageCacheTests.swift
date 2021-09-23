import XCTest
@testable import Networking

final class ImageCacheTests: XCTestCase {

    // MARK: - Tests
    func test_initImageCache_requestUnsavedImage_returnsNil() throws {

        // GIVEN an image cache
        let sut = ImageCache()

        // WHEN an image is requested that is not held in cache
        let url = try XCTUnwrap(URL(string: "https://images2.imgbox.com/4f/e3/I0lkuJ2e_o.png"))
        let image = sut.get(key: url)

        // THEN the image should be nil
        XCTAssertNil(image)
    }

    func test_initImageCache_saveImage_requestImageReturnsExpectation() throws {

        // GIVEN an image cache
        let sut = ImageCache()

        // WHEN an image is saved to the cache
        let savedImage = try XCTUnwrap(savedImageFromBundle())

        let url = try XCTUnwrap(URL(string: "https://images2.imgbox.com/4f/e3/I0lkuJ2e_o.png"))

        sut.set(key: url, image: savedImage)

        // AND the image is then requested
        let image = sut.get(key: url)

        // THEN the image should not be nil
        XCTAssertNotNil(image)
    }

    // MARK: - Private Implementation Details
    private func savedImageFromBundle() -> UIImage? {
        let bundle = Bundle(for: type(of: self))

        return UIImage(named: "falcon-demo.png", in: bundle, compatibleWith: nil)
    }
}
