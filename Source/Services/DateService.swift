import Foundation

enum DateService {
    enum Format {
        case day // [Сегодня|Вчера|11 ноября]
        case dayNumber // 23
        case dayTime // [Сегодня|Вчера|11 нобяря] 11:00
        case month // Январь
        case year // 2024
        case dayTimeDot // [Сегодня|Вчера|11 нобяря] • 11:00
        case dayMonthYear // 22.04.2025 or 04/22/2025 depends on localization
    }
    
    private enum Constants {
        static let monthDayYearFormat = "MM.dd.yyyy"
        static let dayMonthYearFormat = "dd.MM.yyyy"
    }
    
    static func convert(date: Date, format: Format) -> String {
        switch format {
        case .day:
            return convertToDay(date: date)
        case .dayNumber:
            return convertToDayNumber(date: date)
        case .dayTime:
            return convertToDay(date: date) + .space + convertToTime(date: date)
        case .month:
            return convertToMonth(date: date)
        case .year:
            return convertToYear(date: date)
        case .dayTimeDot:
            return convertToDay(date: date) + .space + "•" + .space + convertToTime(date: date)
        case .dayMonthYear:
            return convertToDayMonthYear(date: date)
        }
    }
    
    private static func convertToDay(date: Date) -> String {
        switch calculateDaysToNow(fromDate: date) {
        case .zero:
            return R.string.common.dateTodayName()
        case .one:
            return R.string.common.dateYesterdayName()
        default:
            return date.formatted(
                .dateTime
                    .day()
                    .month(.wide)
            )
        }
    }
    
    static func calculateDaysToNow(fromDate: Date) -> Int {
        let fromDate = Calendar.appCalendar.startOfDay(for: fromDate)
        let toDate = Calendar.appCalendar.startOfDay(for: .now)
        
        return Calendar.appCalendar.dateComponents([.day], from: fromDate, to: toDate).day ?? .zero
    }
    
    private static func convertToYear(date: Date) -> String {
        return date.formatted(
            .dateTime
                .year()
        )
    }
    
    private static func convertToMonth(date: Date) -> String {
        return date.formatted(
            .dateTime
                .month(.wide)
        )
        .lowercased()
        .capitalized
    }
    
    private static func convertToDayNumber(date: Date) -> String {
        date.formatted(
            .dateTime
                .day()
        )
    }
    
    private static func convertToTime(date: Date) -> String {
        return date.formatted(
            .dateTime
                .hour(.twoDigits(amPM: .omitted))
                .minute(.twoDigits)
        )
    }
    
    private static func convertToDayMonthYear(date: Date) -> String {
        let formatter = DateFormatter()
                
        switch LanguageService.appLanguage {
        case .english:
            formatter.dateFormat = Constants.monthDayYearFormat
        case .russian:
            formatter.dateFormat = Constants.dayMonthYearFormat
        }

        return formatter.string(from: date)
    }
}
