//
//  UserRegistrationModel.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//

import Foundation

struct UserRegistrationModel: Decodable {
    let userId: String
    let isVerified: Bool
    let email: String
    @TimeIntervalDate var dispatchedAt: Date
    @TimeIntervalDate var createdAt: Date
}
