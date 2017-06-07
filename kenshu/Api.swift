import Foundation
import APIKit
import Himotoki

protocol ApiRequest: Request { }

extension ApiRequest {
    var baseURL: URL {
        return URL(string: "http://54.238.252.116")!
    }
}

extension ApiRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
