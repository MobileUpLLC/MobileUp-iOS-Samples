//
//  OnboardingTipViewStyle.swift
//  com.samples.app
//
//  Created by Natalia Luzyanina on 05.05.2025.
//

import TipKit

struct OnboardingTipViewStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 16) {
            configuration.message?
                .font(.body)
                .bold()
                .fontWeight(.regular)
                .foregroundStyle(.secondary)
            HStack {
                if let action = configuration.actions.first {
                    Button(action: action.handler, label: {
                        action.label()
                    })
                    .buttonStyle(.borderedProminent)
                }
                Button(action: {
                    configuration.tip.invalidate(reason: .tipClosed)
                }, label: {
                    Text("Закрыть")
                })
                .buttonStyle(.bordered)
            }
            
        }
        .fontDesign(.serif)
        .tint(.purple)
        .padding(20)
    }
}
