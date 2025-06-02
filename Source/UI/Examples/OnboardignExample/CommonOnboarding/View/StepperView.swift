//
//  StepperView.swift
//  com.samples.app
//
//  Created by Victor Kostin on 21.04.2025.
//

import SwiftUI

struct StepperView: View {
    let progress: Int
    let pagesCount: Int
    
    var body: some View {
        GeometryReader { geometry in
            let rectWidth = (geometry.size.width - CGFloat((pagesCount - 1) * 2)) / CGFloat(pagesCount)
            HStack(spacing: 2) {
                ForEach(0..<pagesCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: rectWidth, alignment: .leading)
                        .foregroundColor(getColor(index: index))
                }
            }
        }
        .frame(height: 4)
    }
    private func getColor(index: Int) -> Color {
        index <= progress ? .white : .gray
    }
}

#Preview {
    StepperView(progress: 3, pagesCount: 14)
}
