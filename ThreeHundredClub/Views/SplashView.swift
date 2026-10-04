import SwiftUI

/// Brief branded screen shown once at launch, then faded out by `RootView`.
struct SplashView: View {
    @State private var hasAppeared = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(alignment: .leading, spacing: -10) {
                HStack(alignment: .lastTextBaseline, spacing: 0) {
                    Text("300")
                        .font(.system(size: 150, weight: .black))
                        .tracking(-8)
                    Circle()
                        .fill(Color.brandAccent)
                        .frame(width: 26, height: 26)
                        .offset(y: -6)
                }
                Text("CLUB")
                    .font(.system(size: 44, weight: .black))
                    .tracking(2)
                    .padding(.leading, 6)
            }
            .foregroundStyle(.primary)
            .scaleEffect(hasAppeared ? 1 : 0.92)
            .opacity(hasAppeared ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(duration: 0.6)) {
                hasAppeared = true
            }
        }
    }
}

#Preview {
    SplashView()
}
