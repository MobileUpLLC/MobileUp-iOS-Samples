//
//  AuthorizeUserModel.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 29.03.2025.
//

struct AuthorizeUserModel: Decodable {
    let userId: String
    let accessToken: String
    let refreshToken: String
}
