import Foundation

extension Calendar {
    static var appCalendar: Self = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = LanguageService.locale
        
        return calendar
    }()
}
