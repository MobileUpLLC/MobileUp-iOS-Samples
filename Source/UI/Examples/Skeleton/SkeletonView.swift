import SwiftUI

struct SkeletonView: View {
    private enum Constants {
        static let contentText = "Skeleton Module"
    }
    
    @ObservedObject var viewModel: SkeletonViewModel
    
    var body: some View {
        Text(Constants.contentText)
            .skeleton(isLoading: viewModel.isLoading) {
                SkeletonContentView()
            }
    }
}

struct SkeletonContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: .five) {
                CircleBoneView()
                CapsuleBoneView(width: 76, height: 56)
                CapsuleBoneView(width: 106, height: 56)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 20)
            
            ForEach(0..<7) {_ in
                CellBoneView(accessoryViewWidth: 110)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            }
        }
    }
}

private struct CellBoneView: View {
    let accessoryViewWidth: CGFloat
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .center, spacing: 10) {
                CircleBoneView()
                
                VStack(alignment: .leading, spacing: .five) {
                    HStack {
                        CapsuleBoneView(width: 70, height: 30)
                        Spacer()
                        CapsuleBoneView(width: accessoryViewWidth, height: 30)
                    }
                    
                    CapsuleBoneView(width: 140, height: 30)
                }
            }
        }
    }
}

private struct CapsuleBoneView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        BoneView()
            .frame(width: width, height: height)
            .clipShape(Capsule())
    }
}

private struct CircleBoneView: View {
    var body: some View {
        BoneView()
            .frame(width: 56, height: 56)
            .clipShape(Circle())
    }
}

private struct BoneView: View {
    var body: some View {
        Color.gray
    }
}

struct SkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonView(viewModel: SkeletonViewModel())
    }
}
