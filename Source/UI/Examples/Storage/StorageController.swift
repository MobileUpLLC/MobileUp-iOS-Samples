final class StorageController: HostingController<StorageView> {
    init(viewModel: StorageViewModel) {
        super.init(rootView: StorageView(viewModel: viewModel))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
