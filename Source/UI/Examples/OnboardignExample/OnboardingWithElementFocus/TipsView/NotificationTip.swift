//
//  NotificationTip.swift
//  com.samples.app
//
//  Created by Natalia Luzyanina on 05.05.2025.
//

import TipKit

struct NotificationTip: Tip {
    @Parameter static var hasViewedFavoritesTip: Bool = false

    var title: Text {
        Text("Уведомления")
    }

    var message: Text? {
        Text("Нажмите здесь, чтобы просмотреть уведомления.")
    }

    var image: Image? {
        Image(systemName: "bell")
    }

    var rules: [Rule] {
        [
            #Rule(Self.$hasViewedFavoritesTip) { $0 == true }
        ]
    }

    var actions: [Action] {
        Action(id: "add-to-favorites", title: "Узнать больше", perform: {
            print("Узнать больше")
        })
    }
}
