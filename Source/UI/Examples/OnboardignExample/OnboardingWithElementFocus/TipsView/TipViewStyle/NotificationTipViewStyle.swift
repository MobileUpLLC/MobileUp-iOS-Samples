//
//  NotificationTipViewStyle.swift
//  com.samples.app
//
//  Created by Natalia Luzyanina on 29.04.2025.
//

import TipKit

struct NotificationTipViewStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top, spacing: 8) {
            configuration.image?
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(.orange)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    configuration.title
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        configuration.tip.invalidate(reason: .tipClosed)
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                    })
                }
                configuration.message?
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                actionButton(actions: configuration.actions)
            }
        }
        .padding()
        .background(.gray.opacity(0.2))
    }

    private func actionButton(actions: [Tips.Action]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(actions) { action in
                Button(action: action.handler, label: {
                    action.label()
                })
                .tint(.orange)
            }
        }
    }
}
