import SwiftUI

// вызвать resignFirstResponder тапом по view
extension View {
    func resignResponderOnTap() -> some View {
        return self
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}
