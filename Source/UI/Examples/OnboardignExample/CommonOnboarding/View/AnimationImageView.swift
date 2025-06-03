//
//  AnimationImageView.swift
//  com.samples.app
//
//  Created by Victor Kostin on 21.04.2025.
//

import SwiftUI
import Kingfisher

struct AnimationImageView: View {
    let imageName: String?
    
    private var imageUrl: URL? {
        Bundle.main.url(forResource: imageName, withExtension: ".gif")
    }
    
    var body: some View {
        KFAnimatedImage(imageUrl)
    }
}
