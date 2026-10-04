import SwiftUI

/// Main screen: a grid of headline stats and the list of recent games.
struct HomeView: View {
    let viewModel: GameListViewModel
    @State private var isAddingGame = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    statsGrid
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }

                Section {
                    if viewModel.games.isEmpty {
                        ContentUnavailableView(
                            "No games yet",
                            systemImage: "figure.bowling",
                            description: Text("Tap + to log your first game.")
                        )
                        .listRowSeparator(.hidden)
                    } else {
                        ForEach(viewModel.gamesNewestFirst) { game in
                            GameRow(game: game)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.delete(game)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                } header: {
                    Text("Recent")
                        .font(.title2.weight(.black))
                        .foregroundStyle(.primary)
                        .textCase(nil)
                }
            }
            .listStyle(.plain)
            .navigationTitle("300 Club")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isAddingGame = true
                    } label: {
                        Label("Add Game", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingGame) {
                AddGameView(viewModel: viewModel)
            }
        }
        .tint(Color.brandAccent)
    }

    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            StatTile(title: "Average", value: formattedAverage, isHighlighted: true)
            StatTile(title: "High score", value: viewModel.highScore.map { String($0) } ?? "—")
            StatTile(title: "Games", value: String(viewModel.gameCount))
            StatTile(title: "This week", value: String(viewModel.gamesThisWeek()))
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private var formattedAverage: String {
        guard let average = viewModel.averageScore else { return "—" }
        return average.formatted(.number.precision(.fractionLength(0)))
    }
}

#Preview("With games") {
    HomeView(viewModel: GameListViewModel(games: [
        Game(date: .now, location: "Lucky Strike", score: 212),
        Game(date: .now.addingTimeInterval(-86_400), location: "Lucky Strike", score: 178),
        Game(date: .now.addingTimeInterval(-6 * 86_400), location: "Bowlero", score: 300),
        Game(date: .now.addingTimeInterval(-9 * 86_400), location: "AMF Lanes", score: 164),
    ]))
}

#Preview("Empty") {
    HomeView(viewModel: GameListViewModel())
}
