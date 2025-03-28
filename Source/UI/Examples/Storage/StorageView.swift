import SwiftUI

struct StorageView: View {
    @ObservedObject var viewModel: StorageViewModel

    var body: some View {
        VStack {
            Text(R.string.examples.storageTitle())
                .font(.headline)
            
            TextField(R.string.examples.storagePlaceholder(), text: $viewModel.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(R.string.examples.storageSaveToCache()) {
                viewModel.onSaveToCacheButtonTapped()
            }
            Button(R.string.examples.storageLoadFromCache()) {
                viewModel.onLoadFromCacheButtonTapped()
            }
            Button(R.string.examples.storageClearCache()) {
                viewModel.onRemoveAllFromCacheButtonTapped()
            }
            Text(R.string.examples.storageCacheText(viewModel.messageInCache))
                .padding()
            Button(R.string.examples.storageTitleSaveToDisk()) {
                viewModel.onSaveOnDiskButtonTapped()
            }
            Button(R.string.examples.storageTitleLoadFromDisk()) {
                viewModel.onLoadFromDiskButtonTapped()
            }
            Button(R.string.examples.storageTitleClearDisk()) {
                viewModel.onRemoveAllFromDiskButtonTapped()
            }
            Text(R.string.examples.storageDiskText(viewModel.messageOnDisk))
                .padding()
            
            Button(R.string.examples.storageSaveToKeychain()) {
                viewModel.onSaveToKeychainButtonTapped()
            }
            Button(R.string.examples.storageLoadFromKeychain()) {
                viewModel.onLoadFromKeychainButtonTapped()
            }
            Button(R.string.examples.storageClearKeychain()) {
                viewModel.onRemoveAllFromKeychainButtonTapped()
            }
            Text(R.string.examples.storageKeychainText(viewModel.messageInKeychain))
                .padding()
            Spacer()
        }
        .padding()
        .alert(R.string.common.errorStateTitle(), isPresented: $viewModel.isShowingAlert) {
            Button(R.string.examples.storageOkButtonTitle(), role: .cancel) { }
        }
    }
}

#Preview {
    StorageView(viewModel: .init(storageRepository: .shared))
}
