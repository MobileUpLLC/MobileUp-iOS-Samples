import UIKit

struct ToastViewItem {
    enum Style {
        case information
        case success
        case failure
    }
    
    let style: Style
    let message: String
    let leftIcon: UIImage?
    let rightIcon: UIImage?
}

class ToastView: ToastBaseView {
    private let messageLabel = UILabel()
    private let leftIcon = UIImageView()
    private let rightIcon = UIImageView()
    
    init(item: ToastViewItem, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView(with: item)
    }
    
    private func setupView(with item: ToastViewItem) {
        backgroundColor = getBackgroundColor(with: item.style)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        setupLeftIcon(with: item)
        setupRightIcon(with: item)
        setupMessageLabel(with: item)
    }
    
    private func setupLeftIcon(with item: ToastViewItem) {
        if let image = item.leftIcon {
            leftIcon.image = image.withRenderingMode(.alwaysTemplate)
            leftIcon.tintColor = getForegroundColor(with: item.style)
            
            addSubview(leftIcon)
            
            leftIcon.snp.makeConstraints {
                $0.top.equalToSuperview().inset(16)
                $0.leading.equalToSuperview().inset(20)
                $0.size.equalTo(16)
            }
        }
    }
    
    private func setupRightIcon(with item: ToastViewItem) {
        if let image = item.rightIcon {
            rightIcon.image = image.withRenderingMode(.alwaysTemplate)
            rightIcon.tintColor = getForegroundColor(with: item.style)
            
            addSubview(rightIcon)
            
            rightIcon.snp.makeConstraints {
                $0.top.equalToSuperview().inset(16)
                $0.trailing.equalToSuperview().inset(20)
                $0.size.equalTo(16)
            }
        }
    }
    
    private func setupMessageLabel(with item: ToastViewItem) {
        messageLabel.text = item.message
        messageLabel.font = UIFont.systemFont(ofSize: 12)
        messageLabel.textColor = getForegroundColor(with: item.style)
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            
            if item.leftIcon == nil {
                $0.leading.equalToSuperview().inset(20)
            } else {
                $0.leading.equalTo(leftIcon.snp.trailing).offset(8)
            }
            
            if item.rightIcon == nil {
                $0.trailing.equalToSuperview().inset(20)
            } else {
                $0.trailing.equalTo(rightIcon.snp.leading).offset(-8)
            }
        }
    }
    
    private func getForegroundColor(with style: ToastViewItem.Style) -> UIColor {
        switch style {
        case .success:
            return R.color.icon.iconPrimary.asUIColor
        case .failure:
            return R.color.icon.iconPrimary.asUIColor
        case .information:
            return R.color.icon.iconPrimary.asUIColor
        }
    }
    
    private func getBackgroundColor(with style: ToastViewItem.Style) -> UIColor {
        switch style {
        case .success:
            return .gray.withAlphaComponent(0.3)
        case .failure:
            return .gray.withAlphaComponent(0.3)
        case .information:
            return .gray.withAlphaComponent(0.3)
        }
    }
}
