//
//  OnboardingTip.swift
//  com.samples.app
//
//  Created by Natalia Luzyanina on 05.05.2025.
//

import TipKit

@available(iOS 17.0, *)
struct OnboardingTip: Tip {
    static let favoritesButtonTapped = Tip.Event(id: "profileButtonTapped")

    var title: Text {
        Text("")
    }

    var message: Text? {
        Text("На этом экране реализованы примеры подсказок с фокусом на элементы")
    }

    var image: Image? {
        Image(systemName: "star")
    }

    var actions: [Action] {
        Action(id: "add-to-favorites", title: "Далее", perform: {
            print("Далее")
        })

        Action(id: "learn-more", title: "Узнать больше", perform: {
            print("Узнать больше")
        })
    }
}
