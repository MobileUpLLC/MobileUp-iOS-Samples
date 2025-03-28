import UIKit

final class LogsController: HostingController<LogsView> {
    init() {
        super.init(rootView: LogsView())
        
        view.backgroundColor = .white
    }
}
