import SwiftUI

// Считывает геометрию view после указанной задержки
// это необходимо что бы view успела рассчитать свои размеры
extension View {
    func readGeometry(
        after: TimeInterval = .zero,
        edgesIgnoringSafeArea: Edge.Set = .all,
        completion: @escaping Closure.Generic<CGRect>
    ) -> some View {
        GeometryReader { geometry in
            self.onAppear(after: after) {
                completion(geometry.frame(in: .global))
            }
        }
        .ignoresSafeArea(edges: edgesIgnoringSafeArea)
    }
    
    func onAppear(after: TimeInterval, action: @escaping Closure.Void) -> some View {
        self.onAppear {
            onMainAfter(deadline:.now() + after) {
                action()
            }
        }
    }
}
