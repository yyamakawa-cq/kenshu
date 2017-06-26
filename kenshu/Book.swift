import Foundation
import APIKit
import Himotoki

struct Book: Decodable {
    var id: Int // swiftlint:disable:this identifier_name
    var imageUrl: String
    var title: String
    var price: Int
    var purchaseDate: String

    static func decode(_ e: Extractor) throws -> Book { // swiftlint:disable:this identifier_name
        return try Book(
            id:e <| "id",
            imageUrl:e <| "image_url",
            title:e <| "name",
            price:e <| "price",
            purchaseDate:e <| "purchase_date"
        )
    }
}

struct BookGetResponse:Decodable {
    var book: [Book]
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
