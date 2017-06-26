import Foundation
import UIKit
import APIKit
import Himotoki

struct BookGet: Decodable {
    var id: Int // swiftlint:disable:this identifier_name
    var imageUrl: String
    var name: String
    var price: Int
    var purchaseDate: String

    static func decode(_ e: Extractor) throws -> BookGet { // swiftlint:disable:this identifier_name
        return try BookGet(
            id:e <| "id",
            imageUrl:e <| "image_url",
            name:e <| "name",
            price:e <| "price",
            purchaseDate:e <| "purchase_date"
        )
    }
}

struct BookPost {
    var image: UIImage
    var name: String
    var price: String
    var purchaseDate: String
}

struct BookGetResponse:Decodable {
    var book: [BookGet]
    static func decode(_ e: Extractor) throws -> BookGetResponse { // swiftlint:disable:this identifier_name
        return try BookGetResponse(
            book:e <|| "result"
        )
    }
}

struct BookPostResponse:Decodable {
    var bookId: Int
    static func decode(_ e: Extractor) throws -> BookPostResponse { // swiftlint:disable:this identifier_name
        return try BookPostResponse(
            bookId:e <| "book_id"
        )
    }
}
