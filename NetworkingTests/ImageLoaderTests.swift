import XCTest
@testable import Networking

final class ImageLoaderTests: XCTestCase {

    // MARK: - Tests
    func test_initImageLoader_fetchImage_returnsSuccess() throws {

        // GIVEN an instance of ImageLoader
        let sut = ImageLoader()

        let expectation = self.expectation(description: "Fetch falcon demo image")
        let url = try XCTUnwrap(URL(string: "https://images2.imgbox.com/4f/e3/I0lkuJ2e_o.png"))

        // WHEN an image is requested
        let publisher = sut.loadImage(for: url)
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { image in
                // THEN the image is valid
                XCTAssertNotNil(image)
            })

        XCTAssertNotNil(publisher)
        wait(for: [expectation], timeout: 10.0)
    }
}
