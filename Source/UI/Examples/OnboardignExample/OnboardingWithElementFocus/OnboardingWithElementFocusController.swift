import UIKit
import TipKit
import SnapKit

@available(iOS 17.0, *)
final class OnboardingWithElementFocusController: HostingController<OnboardingWithElementFocusView> {
    let profileTip = ProfileTip.shared
    lazy var tipView = TipUIView(self.profileTip)
    
    init(viewModel: OnboardingWithElementFocusViewModel) {
        super.init(rootView: OnboardingWithElementFocusView(viewModel: viewModel))
        let newBarButtonItem = UIBarButtonItem(
            image: R.image.ic24.cancel.asUIImage,
            style: .plain,
            target: self,
            action: #selector(handleTapOnNavigationRightItem)
        )
        
        navigationBarItem = .init(
            rightItems: [
                .init(type: .button(newBarButtonItem))
            ]
        )
//        пробовал с помощью profileTip.shouldDisplayUpdates проверить изменения статуса показа подсказки
//        что бы ее скрыть вовремя самому
//        Task { @MainActor in
//            try? await Task.sleep(nanoseconds: 1_000_000_000)
//            for await shouldDisplay in profileTip.shouldDisplayUpdates {
//                if shouldDisplay {
//                    tipView.removeFromSuperview()
//                } else {
//                    self.view.addSubview(self.tipView)
//                    
//                    // Позиционируем подсказку рядом с кнопкой navigation bar
//                    
//                }
//            }
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            // Добавляем tipView к view контроллера
            guard let self else {
                return
            }
            self.view.addSubview(self.tipView)
            
            if let barButtonView = newBarButtonItem.value(forKey: "view") as? UIView {
                self.tipView.snp.makeConstraints { make in
                    make.top.equalTo(barButtonView.snp.bottom).offset(20)
                    make.trailing.equalTo(barButtonView.snp.leading)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func handleTapOnNavigationRightItem() {
        ProfileTip.profileButtonTapped.sendDonation()
        // скрывыем подсказку руками
//        tipView.removeFromSuperview()
    }
}


@available(iOS 17.0, *)
struct ProfileTip: Tip {
    static let profileButtonTapped = Tip.Event(id: "profileButtonTapped")
    
    static let shared = ProfileTip()
    
    var title: Text {
        Text("Профиль")
    }
    
    var message: Text? {
        Text("Нажмите здесь, чтобы просмотреть.")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.profileButtonTapped) { $0.donations.count > 2 }
        ]
    }
}
