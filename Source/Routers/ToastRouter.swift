import UIKit

enum ToastDirection {
    case top
    case bottom
}

enum ToastType {
    case global
    case local
}

struct ToastItem {
    let viewItem: ToastViewItem
    let toastType: ToastType
    let direction: ToastDirection
    let duration: TimeInterval
    let isHideOnTap: Bool
    let onTap: Closure.Void?
}

extension ToastItem {
    init(message: String, style: ToastViewItem.Style) {
        self.viewItem = ToastViewItem(
            style: style,
            message: message,
            leftIcon: Self.getDebugIcon(style: style),
            rightIcon: nil
        )
        self.toastType = .local
        self.direction = .bottom
        self.duration = .three
        self.isHideOnTap = true
        self.onTap = {}
    }

    static func getDebugIcon(style: ToastViewItem.Style) -> UIImage {
        switch style {
        case .information:
            return UIImage(systemName: "info.circle") ?? UIImage()
        case .success:
            return UIImage(systemName: "checkmark.circle") ?? UIImage()
        case .failure:
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
    }
}

protocol ToastRouter: AnyObject {
    func showToast(with item: ToastItem)
    func showErrorToast(with message: String)
}

extension UIViewController: ToastRouter {
    func showToast(with item: ToastItem) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        let toastView = ToastView(item: item.viewItem)

        var fromView: UIView

        switch item.toastType {
        case .global:
            fromView = window
        case .local:
            fromView = view
        }

        ToastPresenter.shared.showToast(
            toastView: toastView,
            fromView: fromView,
            direction: item.direction,
            duration: item.duration,
            insets: .init(top: 56, left: 16, bottom: 120, right: 16),
            isHideOnTap: item.isHideOnTap,
            onTap: item.onTap
        )
    }

    func showErrorToast(with message: String) {
        let toastItem = ToastItem(message: message, style: .failure)
        showToast(with: toastItem)
    }
}

private class ToastPresenter {
    enum Constants {
        static var defaultToastAnimationDurationInSeconds: TimeInterval { 0.3 }
    }

    static let shared = ToastPresenter()

    private weak var previosView: UIView?

    private init() {}

    func showToast(
        toastView: ToastView,
        fromView: UIView,
        direction: ToastDirection,
        duration: TimeInterval,
        insets: UIEdgeInsets,
        isHideOnTap: Bool,
        onTap: Closure.Void?
    ) {
        removeToast(fromView: fromView)

        if let previosView {
            removeToast(fromView: previosView)
        }

        previosView = fromView

        toastView.setup(
            swipeDirection: direction == .bottom ? .down : .up,
            onTap: { [weak toastView, weak self] in
                if isHideOnTap {
                    self?.remove(toastView: toastView)
                    onTap?()
                }
            },
            onSwipe: { [weak toastView, weak self] in self?.remove(toastView: toastView) }
        )

        fromView.addSubview(toastView)

        let fittingSize = CGSize(
            width: fromView.bounds.width,
            height: UIView.layoutFittingCompressedSize.height
        )

        let toastViewSize = toastView.systemLayoutSizeFitting(
            fittingSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        let finalYPosition: CGFloat

        switch direction {
        case .top:
            finalYPosition = insets.top
        case .bottom:
            finalYPosition = fromView.bounds.height - insets.bottom - toastViewSize.height
        }

        toastView.frame = CGRect(
            x: insets.left,
            y: finalYPosition,
            width: fromView.bounds.width - insets.left - insets.right,
            height: toastViewSize.height
        )
        
        toastView.alpha = .zero
        animateShowToast(with: toastView, and: duration)
    }
    
    private func animateShowToast(with toastView: Toast, and duration: TimeInterval) {
        UIView.animate(
            withDuration: Constants.defaultToastAnimationDurationInSeconds,
            delay: .zero,
            options: .curveEaseInOut,
            animations: { toastView.alpha = .one },
            completion: { [weak self] _ in
                onMainAfter(deadline: .now() + duration) {
                    self?.remove(toastView: toastView)
                }
            }
        )
    }

    private func removeToast(fromView: UIView) {
        fromView.subviews.forEach {
            if let view = $0 as? Toast {
                remove(toastView: view)
            }
        }
    }

    private func remove(toastView: Toast?) {
        guard let toastView = toastView else {
            return
        }

        UIView.animate(
            withDuration: Constants.defaultToastAnimationDurationInSeconds,
            delay: .zero,
            options: .curveEaseInOut,
            animations: { toastView.alpha = .zero },
            completion: { _ in toastView.removeFromSuperview() }
        )
    }
}
