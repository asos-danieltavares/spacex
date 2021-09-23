import XCTest

extension XCTest {

    func jsonData(fromFile resourceFile: String) throws -> Data {

        let testBundle = Bundle(for: Self.self)
        let filePath = try XCTUnwrap(testBundle.path(forResource: resourceFile, ofType: "json"))
        let url = URL(fileURLWithPath: filePath)
        return try Data(contentsOf: url)
    }
}
