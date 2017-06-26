import Foundation
import APIKit
import Himotoki

struct UserResponse: Decodable {
    var id: Int // swiftlint:disable:this identifier_name
    var requestToken: String

// swiftlint:disable:next identifier_name
    static func decode(_ e: Extractor) throws -> UserResponse {
        return try UserResponse(
            id:e <| "user_id",
            requestToken:e <| "request_token"
        )
    }
// swiftlint:disable:previous identifier_name
}
