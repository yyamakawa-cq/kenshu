import Foundation
import APIKit
import Himotoki

struct SignUpRequest: ApiRequest {
    let email:String
    let password:String

    typealias Response = User

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/signup"
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

//    var parameters: [String: String] {
//        return [
//            "mail_address" : self.email,
//            "password" : self.password
//        ]
//    }

    init(email:String, password:String) {
        self.email = email
        self.password = password
    }
}
