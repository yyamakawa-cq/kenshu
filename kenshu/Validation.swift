import Foundation

class Validation {

    static func isEmptycheck(value: String) -> Bool {
        return value != ""
    }

    static func isEqualCheck(pwFirst: String, pwSecond: String) -> Bool {
        return pwFirst == pwSecond
    }

    static func isCountCheck(value: String, count: Int) -> Bool {
        let valueCount = value.characters.count
        return valueCount >= count
    }
}
