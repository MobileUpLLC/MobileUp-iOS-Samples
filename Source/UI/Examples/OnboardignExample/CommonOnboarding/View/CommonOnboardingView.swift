import SwiftUI

struct CommonOnboardingViewItem {
    enum ContentType {
        case image(Image)
        case gif(String)
    }
    
    let title: String
    let description: String
    let type: ContentType
    
    static let empty = CommonOnboardingViewItem(title: .empty, description: .empty, type: .gif(.empty))
}

struct CommonOnboardingView: View {
    @ObservedObject var viewModel: CommonOnboardingViewModel

    private var buttonTitle: String {
        viewModel.isLastPage ? viewModel.finishButtonTitle : R.string.examples.commonOnboardingNextButtonTitle()
    }

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isNeedShowProgress {
                StepperView(progress: viewModel.currentProgress, pagesCount: viewModel.pagesCount)
                    .padding(.top, UIApplication.getSafeAreaInsets().top) 
            }
            Spacer()
            VStack(spacing: 0) {
                Text(viewModel.viewItem.title)
                    .font(.title)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                Text(viewModel.viewItem.description)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                Spacer()
                HStack {
                    Button {
                        viewModel.handleBackButtonTap()
                    } label: {
                        Text(R.string.examples.commonOnboardingBackButtonTitle())
                            .padding(10)
                            .background(.white)
                            .roundedCorner(8, corners: .allCorners)
                    }
                    Spacer()
                    Button {
                        viewModel.handleNextButtonTap()
                    } label: {
                        Text(buttonTitle)
                            .padding(10)
                            .background(.white)
                            .roundedCorner(8, corners: .allCorners)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 34)
            }
            .frame(height: 253)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            switch viewModel.viewItem.type {
            case .image(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .gif(let imageName):
                AnimationImageView(imageName: imageName)
                    .aspectRatio(contentMode: .fill)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CommonOnboardingView(
        viewModel: CommonOnboardingViewModel(
            coordinator: CommonOnboardingCoordinator(),
            onboardingType: .testOnboarding
        )
    )
}
