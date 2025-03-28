import UIKit

class BaseView: Utils.BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @available(*, unavailable) required init(fromCodeWithFrame frame: CGRect) {
        super.init(fromCodeWithFrame: frame)
    }
}
