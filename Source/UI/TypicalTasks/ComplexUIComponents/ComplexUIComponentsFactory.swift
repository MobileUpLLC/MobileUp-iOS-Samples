enum ComplexUIComponentsFactory {
    static func createComplexUIComponentsController() -> ComplexUIComponentsController {
        let controller = ComplexUIComponentsController(rootView: ComplexUIComponentsView())
        
        return controller
    }
}
