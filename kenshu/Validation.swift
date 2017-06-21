import UIKit

class Validation {

    static func isEmpty(value: String) -> Bool {
        return value.isEmpty
    }

    static func isEqual(pwFirst: String, pwSecond: String) -> Bool {
        return pwFirst == pwSecond
    }

    static func checkValueCount(value: String, minCount: Int) -> Bool {
        let valueCount = value.characters.count
        return valueCount >= minCount
    }

}
