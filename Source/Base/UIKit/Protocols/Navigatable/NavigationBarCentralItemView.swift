import UIKit
import SnapKit

final class NavigationBarCentralItemView: BaseView {
    private let item: NavigationBarCentralItem
    
    override func initSetup() {
        super.initSetup()
        
        switch item.type {
        case .title(let title):
            setup(title: title)
        case .customView(let customView):
            setup(customView: customView)
        case .empty:
            break
        }
        
        if item.isLayoutWithAnimation {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
        
        addTapGestureRecognizer()
    }
    
    required init(item: NavigationBarCentralItem) {
        self.item = item
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("initHasNotBeenImplemented")
    }
    
    required init(fromCodeWithFrame frame: CGRect) {
        fatalError("initHasNotBeenImplemented")
    }
    
    private func setup(title: String) {
        let label = UILabel()
        
        label.text = title
        label.font = .Heading.medium
        label.textColor = .black
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setup(customView: UIView) {
        addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))

        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        item.onTapAction?()
    }
}
