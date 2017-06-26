import Foundation
import APIKit
import Himotoki

struct BookListRequest: ApiRequest {
    let page:String

    typealias Response = BookGetResult

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/books"
    }

    var headerFields: [String: String] {
        return [
            "Content-Type": "application/json",
            "Authorization": UserDefaults.standard.string(forKey:"request_token")!
        ]
    }

    var parameters: Any? {
        return [
            "user_id": UserDefaults.standard.integer(forKey: "user_id"),
            "page": self.page
        ]
    }
}
