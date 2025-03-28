enum SkeletonFactory {
    static func createSkeletonController() -> SkeletonController {
        let viewModel = SkeletonViewModel()
        let controller = SkeletonController(viewModel: viewModel)
        
        return controller
    }
}
