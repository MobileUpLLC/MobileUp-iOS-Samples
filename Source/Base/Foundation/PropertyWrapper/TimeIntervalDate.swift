//
//  TimeIntervalDate.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//

import Foundation

@propertyWrapper
struct TimeIntervalDate: Decodable, Encodable {
    var wrappedValue: Date

    init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let timestamp = try container.decode(Int.self)
        self.wrappedValue = Date(timeIntervalSince1970: TimeInterval(timestamp))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Int(wrappedValue.timeIntervalSince1970))
    }
}

@propertyWrapper
struct TimeIntervalOptionalDate: Decodable, Encodable {
    var wrappedValue: Date?

    init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let timestamp = try? container.decode(Int?.self) {
            self.wrappedValue = Date(timeIntervalSince1970: TimeInterval(timestamp))
        } else {
            self.wrappedValue = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let date = wrappedValue {
            try container.encode(Int(date.timeIntervalSince1970))
        } else {
            try container.encodeNil()
        }
    }
}
