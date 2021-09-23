import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]

    init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spacexdata.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
