import SwiftUI

final class WebPageController: HostingController<WebPageView> {
    init(viewModel: WebPageViewModel) {
        super.init(rootView: WebPageView(viewModel: viewModel))
        
        let rightItem = NavigationBarSideItem(
            type: .icon(R.image.ic24.cancel.asUIImage),
            onTapAction: { [weak self] in self?.rootView.viewModel.dismiss() }
        )
        
        let centralItem = NavigationBarCentralItem(type: .title(viewModel.navigationTitle))
        
        navigationBarItem = NavigationBarItem(centralItem: centralItem, rightItems: [rightItem])
    }
}
