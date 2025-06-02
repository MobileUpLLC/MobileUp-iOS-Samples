//
//  LoaderView.swift
//  com.samples.app
//
//  Created by Кирилл Кошкарёв on 31.03.2025.
//

import SwiftUI

struct LoaderView: View {
    @State private var loaderRotation: Double = .zero
    
    private let progress: Float
    private let startGradientColor: Color
    private let endGradientColor: Color
    private let lineWidth: CGFloat
    
    var body: some View {
        ProgressView(value: progress)
            .rotationEffect(.degrees(loaderRotation))
            .progressViewStyle(
                ProgressStyle(
                    startGradientColor: startGradientColor,
                    endGradientColor: endGradientColor,
                    lineWidth: lineWidth
                )
            )
            .task {
                withAnimation(.linear(duration: .one).repeatForever(autoreverses: false)) {
                    loaderRotation = 360
                }
            }
    }
    
    init(
        progress: Float,
        startGradientColor: Color = .blue,
        endGradientColor: Color = .black,
        lineWidth: CGFloat = 6
    ) {
        self.progress = progress
        self.startGradientColor = startGradientColor
        self.endGradientColor = endGradientColor
        self.lineWidth = lineWidth
    }
}

private struct ProgressStyle: ProgressViewStyle {
    let startGradientColor: Color
    let endGradientColor: Color
    let lineWidth: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return ZStack {
            Circle()
                .stroke(.clear, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(
                    LinearGradient(
                        colors: [startGradientColor, endGradientColor],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
        }
    }
}
