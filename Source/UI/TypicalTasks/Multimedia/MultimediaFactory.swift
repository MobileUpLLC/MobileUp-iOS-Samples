enum MultimediaFactory {
    static func createMiltimediaController() -> MultimediaController {
        let controller = MultimediaController(rootView: MultimediaView())
        
        return controller
    }
}
