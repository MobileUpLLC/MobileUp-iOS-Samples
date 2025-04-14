import UIKit

extension String {
    private enum Constants {
        static let backendDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        static let dayOnlyDateFormat = "d"
        static let fullDateFormat = "d MMMM yyyy"
        static let defaultDateFormat = "d MMMM"
    }
    
    static var divider: Self { "|" }
    static var tilde: Self { "~" }
    static var squareLeftBracket: Self { "[" }
    static var squareRightBracket: Self { "]" }
    static var phoneNumberRegionCode: Self { "+7" }
    static var onlyNumbersRegularExpression: Self { "[^0-9]" }
    static var onlyNumbersAndEnLettersRegularExpression: Self { "[^0-9A-Za-z]" }
    static var phoneNumberRegularExpression: Self {
        #"^\+?7?[ ][(]?[0-9]{3}[)][ ]?[0-9]{3}[-]?[0-9]{2}[-]?[0-9]{2}.*$"#
    }
    static var emptyEmailRegularExpression: Self {
        #"^(?:[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}|)$"#
    }
    
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: .zero, length: nsString.length))
            
            return results.map { nsString.substring(with: $0.range) }
        } catch {
            return []
        }
    }
    
    func deleteSquareBrackets() -> String {
        return self
            .replacingOccurrences(of: Self.squareLeftBracket, with: String.empty)
            .replacingOccurrences(of: Self.squareRightBracket, with: String.empty)
    }
    
    func frameSize(
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        font: UIFont
    ) -> CGSize {
        let width = maxWidth ?? CGFloat.greatestFiniteMagnitude
        let height = maxHeight ?? CGFloat.greatestFiniteMagnitude
        
        let attributedText = NSAttributedString(
            string: self,
            attributes: [.font: font]
        )
        
        let constraintBox = CGSize(width: width, height: height)
        
        let rect = attributedText.boundingRect(
            with: constraintBox,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        .integral
        
        return rect.size
    }
    
    func append(newValue: String) -> String {
        return self + newValue
    }
    
    func getFormattedDate(format: String = Constants.defaultDateFormat) -> String? {
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = Constants.backendDateFormat
        let date = isoDateFormatter.date(from: self) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
    
    func getDatePeriodDescription(dateEnd: String?) -> String? {
        guard let dateEnd else {
            return self.getFormattedDate(format: Constants.fullDateFormat)
        }
        
        let calendar = Calendar.current
        
        let startDateComponents = calendar.dateComponents([.day, .month, .year], from: self.convertToDate())
        let endDateComponents = calendar.dateComponents([.day, .month, .year], from: dateEnd.convertToDate())
        
        let isSameYear = startDateComponents.year == endDateComponents.year
        let isSameMonth = startDateComponents.month == endDateComponents.month
        let isSameDay = startDateComponents.day == endDateComponents.day
        
        var startDate: String?
        
        if isSameYear && isSameMonth {
            startDate = self.getFormattedDate(format: Constants.dayOnlyDateFormat)
        } else if isSameYear {
            startDate = self.getFormattedDate()
        } else {
            startDate = self.getFormattedDate(format: Constants.fullDateFormat)
        }
        
        guard
            let startDate,
            let endDate = dateEnd.getFormattedDate(format: Constants.fullDateFormat)
        else {
            return nil
        }
        
        if isSameYear && isSameMonth && isSameDay {
            return endDate
        } else {
            return startDate + .space + .dash + .space + endDate
        }
    }
    
    func convertToDate(withFormat format: String = Constants.backendDateFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func replaceQuotationMark() -> String {
        var resultString: String = .empty
        let characterArray = Array(self)
        
        for i in 0..<characterArray.count {
            if i == 0, characterArray[i] == "\"" {
                resultString.append("«")
            } else if i == characterArray.count - 1, characterArray[i] == "\"" {
                resultString.append("»")
            } else if characterArray[i] == "\"", resultString[i - 1] == " " || resultString[i - 1] == "«" {
                resultString.append("«")
            } else if characterArray[i] == "\"" {
                resultString.append("»")
            } else {
                resultString.append(characterArray[i])
            }
        }
        
        return resultString
    }
    
    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
}
