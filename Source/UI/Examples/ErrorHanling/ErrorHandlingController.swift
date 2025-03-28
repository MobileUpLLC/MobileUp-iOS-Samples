final class ErrorHandlingController: HostingController<ErrorHandlingView> {
    init(viewModel: ErrorHandlingViewModel) {
        super.init(rootView: ErrorHandlingView(viewModel: viewModel))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
