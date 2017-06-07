import Foundation
import APIKit
import Himotoki

struct User: Decodable {
    var id: Int
    var requestToken: String

// swiftlint:disable:next identifier_name
    static func decode(_ e: Extractor) throws -> User {
        return try User(
            id:e <| "user_id",
            requestToken:e <| "request_token"
        )
    }
// swiftlint:disable:previous identifier_name
}
