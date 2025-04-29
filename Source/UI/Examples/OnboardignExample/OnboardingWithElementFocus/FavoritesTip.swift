//
//  FavoritesTip.swift
//  com.samples.app
//
//  Created by Natalia Luzyanina on 29.04.2025.
//

import Foundation
import TipKit

@available(iOS 17.0, *)
struct FavoritesTip: Tip {
    static let profileButtonTapped = Tip.Event(id: "profileButtonTapped")

    var title: Text {
        Text("Избранное")
    }

    var message: Text? {
        Text("Нажмите здесь, чтобы просмотреть ваши избранные элементы.")
    }

    var image: Image? {
        Image(systemName: "star")
    }

    var rules: [Rule] {
        [
            #Rule(Self.profileButtonTapped) { $0.donations.count > 0 }
        ]
    }

    var actions: [Action] {
        Action(id: "add-to-favorites", title: "Добавить в избранное")
        Action(id: "learn-more", title: "Узнать больше")
    }
}
