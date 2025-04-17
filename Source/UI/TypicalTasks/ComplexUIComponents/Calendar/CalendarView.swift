import SwiftUI

struct CalendarView: View {
    @State private var date = Date.now
    
    var body: some View {
        DatePicker("", selection: $date, displayedComponents: [.date])
            .datePickerStyle(.graphical)
            .background(Color.black.opacity(0.2)) // Фон
            .tint(.red) // Цвет элементов управления
            .environment(\.calendar, Calendar(identifier: .iso8601)) // Смена календарной системы
            .environment(\.locale, Locale(identifier: "ru_RU")) // Локализация
            .environment(\.timeZone, TimeZone(abbreviation: "GMT+3")!) // Часовой пояс
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
    }
}

#Preview {
    CalendarView()
}
