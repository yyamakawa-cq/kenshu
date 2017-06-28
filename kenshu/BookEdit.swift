import Foundation
import APIKit
import Himotoki

struct BookEditRequest: ApiRequest {
    let id:Int // swiftlint:disable:this identifier_name
    let name:String
    let price:Int
    let purchaseDate:String
    let imageData:String

    typealias Response = BookPostResponse

    var method: HTTPMethod {
        return .patch
    }

    var path: String {
        return "/books/\(self.id)"
    }

    var headerFields: [String: String] {
        return [
            "Content-Type": "application/json",
            "Authorization": UserDefaults.standard.string(forKey:"request_token")!
        ]
    }

    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "name": self.name,
            "price": self.price,
            "purchase_date": self.purchaseDate,
            "image_data": self.imageData
            ])
    }
}
