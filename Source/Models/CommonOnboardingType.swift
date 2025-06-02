//
//  CommonOnboardingType.swift
//  com.samples.app
//
//  Created by Victor Kostin on 21.04.2025.
//

import Foundation

enum CommonOnboardingType {
    private enum Constants {
        static let secondPageAnimation = "welcomeSecond"
    }
    
    case testOnboarding
    
    var items: [CommonOnboardingViewItem] {
        switch self {
        case .testOnboarding:
            return CommonOnboardingType.testOnboardingItems
        }
    }
    
    var finishButtonTitle: String {
        switch self {
        case .testOnboarding:
            return R.string.examples.testOnboardingFinishButtonTitle()
        }
    }
    
    var isNeedShowProgress: Bool {
        switch self {
        case .testOnboarding:
            return true
        }
    }
    
    static let testOnboardingItems: [CommonOnboardingViewItem] = [
        CommonOnboardingViewItem(
            title: R.string.examples.testOnboardingFirstItemTitle(),
            description: R.string.examples.testOnboardingFirstItemDescription(),
            type: .image(R.image.onboarding.onboardingFirstImage.image)
        ),
        CommonOnboardingViewItem(
            title: R.string.examples.testOnboardingSecondItemTitle(),
            description: R.string.examples.testOnboardingSecondItemDescription(),
            type: .gif(Constants.secondPageAnimation)
        ),
        CommonOnboardingViewItem(
            title: R.string.examples.testOnboardingThirdItemTitle(),
            description: R.string.examples.testOnboardingThirdItemDescription(),
            type: .image(R.image.onboarding.onboardingThirdImage.image)
        )
    ]
}
