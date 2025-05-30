//
//  ErrorModel.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//

import Foundation

struct ErrorModel: Decodable {
    let errors: ErrorDescriptionModel
}

extension ErrorModel {
    struct ErrorDescriptionModel: Decodable {
        let title: String
        let status: Int
        let detail: String
        let source: ErrorSourceModel?
        let modelName: String?
    }
    
    struct ErrorSourceModel: Decodable {
        let pointer: String
    }
}
