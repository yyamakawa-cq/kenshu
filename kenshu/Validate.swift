import Foundation
import UIKit

class Validate {
    static func account(email:String, password:String, comfirmPwd:String) -> (result:Bool, error:String) {
        let strEmail = R.string.localizable.email()
        let strPassword = R.string.localizable.password()
        let strComfirmPwd = R.string.localizable.comfirmPwd()

        guard !email.isEmpty else {
            return (false,R.string.localizable.errorEmpty(strEmail))
        }
        guard !password.isEmpty else {
            return (false,R.string.localizable.errorEmpty(strPassword))
        }
        guard !comfirmPwd.isEmpty else {
            return (false,R.string.localizable.errorEmpty(strComfirmPwd))
        }
        guard password == comfirmPwd else {
            return (false,R.string.localizable.errorPasswod())
        }
        guard email.characters.count >= 8 else {
            return (false,R.string.localizable.errorCount(strEmail))
        }
        guard password.characters.count >= 3 else {
            return (false,R.string.localizable.errorCount(strPassword))
        }
        return (true,"")
    }

    static func login(email:String, password:String) -> (result:Bool, error:String) {
        let strEmail = R.string.localizable.email()
        let strPassword = R.string.localizable.password()

        guard !email.isEmpty else {
            return (false, R.string.localizable.errorEmpty(strEmail))
        }
        guard !password.isEmpty else {
            return (false, R.string.localizable.errorEmpty(strPassword))
        }
        return (true,"")
    }

    static func book(book:BookPost) -> (result:Bool, error: String) {
        let strTitle = R.string.localizable.bookTitle()
        let strPrice = R.string.localizable.bookPrice()
        let strPurchaseDate = R.string.localizable.bookPurchaseDate()
        let strImage = R.string.localizable.bookImage()

        guard !book.name.isEmpty else {
            return (false,R.string.localizable.errorEmpty(strTitle))
        }
        guard !book.price.isEmpty else {
            return (false,R.string.localizable.errorEmpty(strPrice))
        }
        guard !book.purchaseDate.isEmpty else {
            return (false, R.string.localizable.errorEmpty(strPurchaseDate))
        }
        guard book.image != R.image.sample() else {
            return (false, R.string.localizable.errorEmpty(strImage))
        }
        return (true,"")
    }
}
