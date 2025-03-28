final class SkeletonController: HostingController<SkeletonView> {
    init(viewModel: SkeletonViewModel) {
        super.init(rootView: SkeletonView(viewModel: viewModel))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
