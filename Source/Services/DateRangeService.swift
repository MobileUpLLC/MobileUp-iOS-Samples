import Foundation

enum DateRangeService {
    static func addMonthsToDate(count: Int, date: Date) -> Date {
        var components = DateComponents()
        components.month = count
        
        return Calendar.appCalendar.date(byAdding: components, to: date) ?? .now
    }
    
    static func addDayToDate(count: Int, date: Date) -> Date {
        var components = DateComponents()
        components.day = count
        
        return Calendar.appCalendar.date(byAdding: components, to: date) ?? .now
    }
    
    static func addWeekToDate(count: Int, date: Date) -> Date {
        var components = DateComponents()
        components.weekOfYear = count
        
        return Calendar.appCalendar.date(byAdding: components, to: date) ?? .now
    }
    
    static func getFirstDayOfWeek(date: Date) -> Date {
        let components = Calendar.appCalendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        return Calendar.appCalendar.date(from: components) ?? .now
    }
    
    static func getFirstDayOfMonth(date: Date) -> Date {
        let components = Calendar.appCalendar.dateComponents([.year, .month], from: date)
        return Calendar.appCalendar.date(from: components) ?? .now
    }
    
    static func getStartOfDay(date: Date) -> Date {
        return Calendar.appCalendar.startOfDay(for: date)
    }
    
    static func getCurrentYear() -> Int {
        Calendar.appCalendar.component(.year, from: .now)
    }
    
    static func checkEqualDays(lhs: Date, rhs: Date) -> Bool {
        Calendar.appCalendar.isDate(lhs, equalTo: rhs, toGranularity: .day)
    }
    
    static func minutesFromGMT() -> Int {
        return TimeZone.current.secondsFromGMT() / 60
    }
}
