import SwiftUI

struct CalendarView: View {
    private enum Constants {
        static let ruLocaleIdentifier = "ru_RU"
        static let moscowTimeZone = "GMT+3"
    }
    
    @State private var date = Date.now
    
    var body: some View {
        if let timeZone = TimeZone(abbreviation: Constants.moscowTimeZone) {
            DatePicker("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .background(Color.black.opacity(0.2))
                .tint(.red)
                .environment(\.calendar, Calendar(identifier: .iso8601))
                .environment(\.locale, Locale(identifier: Constants.ruLocaleIdentifier))
                .environment(\.timeZone, (timeZone))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
        }
    }
}

#Preview {
    CalendarView()
}
