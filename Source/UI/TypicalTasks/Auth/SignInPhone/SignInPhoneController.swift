final class SignInPhoneController: HostingController<SignInPhoneView> {
    override var isTabBarHidden: Bool { true }
    
    init(viewModel: SignInPhoneViewModel) {
        super.init(rootView: SignInPhoneView(viewModel: viewModel))
    }
}
