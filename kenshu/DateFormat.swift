import Foundation

class DateFormat {
    static func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date)
    }
    class func stringToDate(date: String) -> NSDate {
        let dateFomatter = DateFormatter()
        dateFomatter.timeZone = TimeZone.current
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            dateFomatter.locale = Locale(identifier: countryCode)
        }
        dateFomatter.dateFormat = "EEE, dd MM yyyy HH:mm:ss Z"
        return dateFomatter.date(from: date)! as NSDate
    }
}
