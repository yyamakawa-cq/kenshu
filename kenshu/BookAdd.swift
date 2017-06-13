import Foundation
import APIKit
import Himotoki

struct BookAddRequest: ApiRequest {
    let name:String
    let price:Int
    let purchaseDate:String
    let imageData:String

    typealias Response = BookPostResult

    var method: HTTPMethod {
        return .post
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

    var bodyParameters: BodyParameters? {
        return JSONBodyParameters(JSONObject: [
            "name": self.name,
            "price": self.price,
            "purchase_date": self.purchaseDate,
            "image_data": self.imageData,
            "user_id": UserDefaults.standard.integer(forKey: "user_id")
            ])
    }

    init(name:String, price:Int, purchaseDate:String, imageData:String) {
        self.name = name
        self.price = price
        self.purchaseDate = purchaseDate
        self.imageData = imageData
    }
}
