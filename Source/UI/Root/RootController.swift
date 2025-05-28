import UIKit

final class RootController: UIViewController {
    private let viewModel: RootViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.handleViewDidLoad()
    }
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
