import Foundation
import APIKit
import Himotoki

struct BookEditRequest: ApiRequest {
    let id:Int // swiftlint:disable:this identifier_name
    let name:String
    let price:Int
    let purchaseDate:String
    let imageData:String

    typealias Response = BookPostResult

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

    // swiftlint:disable:next identifier_name
    init(id:Int, name:String, price:Int, purchaseDate:String, imageData:String) {
        self.id = id
        self.name = name
        self.price = price
        self.purchaseDate = purchaseDate
        self.imageData = imageData
    }
    // swiftlint:disable:previos identifier_name
}
