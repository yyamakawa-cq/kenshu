import Foundation

class Book {
    var imageUrl: String
    var title: String
    var price: Int
    var purchasedDate: String

    init() {
        imageUrl = ""
        title = ""
        price = 0
        purchasedDate = ""
    }

    init(imageUrl: String, title: String, price: Int, purchasedDate: String) {
        self.imageUrl = imageUrl
        self.title = title
        self.price = price
        self.purchasedDate = purchasedDate
    }
}
