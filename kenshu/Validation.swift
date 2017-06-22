import Foundation

class Validation {

    static func isNotEmpty(value: String) -> Bool {
        return value != ""
    }

    static func isEqual(pwFirst: String, pwSecond: String) -> Bool {
        return pwFirst == pwSecond
    }

    static func checkValueCount(value: String, minCount: Int) -> Bool {
        let valueCount = value.characters.count
        return valueCount >= minCount
    }

}
