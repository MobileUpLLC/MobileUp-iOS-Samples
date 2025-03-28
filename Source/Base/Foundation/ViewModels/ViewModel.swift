import Foundation
import Combine

class ViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    // При использовании вложенных ObservableObject'ов нужно вручную прокидывать изменения
    // в родительский объект. SwiftUI автоматически не умеет этого делать.
    func addChild(viewModel: ViewModel) {
        viewModel.objectWillChange.sink { [weak self] in
            onMain {
                self?.objectWillChange.send()
            }
        }
        .store(in: &subscriptions)
    }
}
