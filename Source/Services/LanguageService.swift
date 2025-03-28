import Foundation

enum LanguageService {
    enum Language: String {
        case russian = "ru"
        case english = "en"
    }
    
    static var appLanguage: Language { getAppLanguage() }
    static var locale: Locale { getLocale() }
    
    private static func getAppLanguage() -> Language {
        let locale = Locale.current.language.languageCode?.identifier ?? .empty
        
        return Language(rawValue: locale) ?? .english
    }
    
    private static func getLocale() -> Locale {
        switch appLanguage {
        case .russian:
            return Locale(identifier: "ru_RU")
        case .english:
            return Locale(identifier: "en_US")
        }
    }
}
