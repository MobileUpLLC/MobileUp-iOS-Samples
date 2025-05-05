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
                .fontWeight(.regular)
                .foregroundStyle(.secondary)
            HStack {
                Button(action: configuration.actions.first!.handler, label: {
                    configuration.actions.first!.label()
                })
                .buttonStyle(.borderedProminent)
                Button(action: {
                    configuration.tip.invalidate(reason: .tipClosed)
                }, label: {
                    Text("Закрыть")
                })
                .buttonStyle(.bordered)
            }
            
        }
        .padding(20)
    }
}
