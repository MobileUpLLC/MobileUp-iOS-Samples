import UIKit

class TabBarView: ItemsStackView<UIImage, UIImageView> {
    var onItemSelect: Closure.Int?
    
    var selectedIndex: Int = 0 {
        didSet { indexDidChange() }
    }
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.clipsToBounds = true
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blurEffectView.layer.cornerRadius = bounds.height / 2
    }
    
    init(icons: [UIImage]) {
        super.init(
            axis: .horizontal,
            distribution: .fill,
            alignment: .fill,
            spacing: 28,
            edgeInsets: .init(top: 16, left: 32, bottom: 16, right: 32),
            items: icons
        ) { image in
            let view = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            view.contentMode = .scaleAspectFit
            view.snp.makeConstraints { make in
                make.size.equalTo(24)
            }
            
            return view
        }
        
        innerStack.arrangedSubviews.forEach { view in
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.itemTapped(sender:)))
            view.addGestureRecognizer(tapGesture)
        }
        
        indexDidChange()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(fromCodeWithFrame frame: CGRect) {
        fatalError("init(fromCodeWithFrame:) has not been implemented")
    }
    
    private func indexDidChange() {
        blurEffectView.removeFromSuperview()
        insertSubview(blurEffectView, at: .zero)
        
        innerStack.arrangedSubviews.enumerated().forEach { index, view in
            view.tintColor = (index == selectedIndex) ? .blue : .gray
        }
    }
    
    @objc private func itemTapped(sender: UITapGestureRecognizer) {
        let index = innerStack.arrangedSubviews.firstIndex { view in
            view === sender.view
        }
        
        guard let index else {
            return
        }
        
        selectedIndex = index
        onItemSelect?(index)
    }
}
