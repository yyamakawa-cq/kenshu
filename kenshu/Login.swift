import Foundation
import APIKit
import Himotoki

struct LoginRequest: ApiRequest {
    let email:String
    let password:String

    typealias Response = UserResponse

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/login"
    }

    var headerFields: [String: String] {
        return ["Content-Type": "application/json"]
    }

    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "email": self.email,
            "password": self.password
            ])
    }
}
