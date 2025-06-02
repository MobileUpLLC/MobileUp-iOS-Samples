//
//  TipsService.swift
//  TypicalTasks
//
//  Created by Natalia Luzyanina on 12.05.2025.
//

import TipKit

class TipsService {
    static let shared = TipsService()
    
    private init() {}

    func configureTip() {
        if #available(iOS 17.0, *) {
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
    }
}
