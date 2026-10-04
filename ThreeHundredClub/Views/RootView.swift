import SwiftUI

/// Top-level view. Owns the shared view model and decides whether the splash
/// or the home screen is on screen.
struct RootView: View {
    @State private var viewModel = GameListViewModel()
    @State private var isShowingSplash = true

    private let splashDuration: Duration = .seconds(1.4)

    var body: some View {
        ZStack {
            if isShowingSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                HomeView(viewModel: viewModel)
            }
        }
        .task {
            // Hold the splash briefly, then cross-fade to the real UI.
            try? await Task.sleep(for: splashDuration)
            withAnimation(.easeOut(duration: 0.35)) {
                isShowingSplash = false
            }
        }
    }
}

#Preview {
    RootView()
}
