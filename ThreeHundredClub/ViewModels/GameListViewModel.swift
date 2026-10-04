import Foundation
import Observation

/// Owns the list of games and the actions that change it.
///
/// Deliberately knows nothing about SwiftUI so it can be unit tested directly.
/// Storage is in-memory for now; SwiftData replaces the array in the next stage.
@Observable
final class GameListViewModel {
    private(set) var games: [Game]

    init(games: [Game] = []) {
        self.games = games
    }

    // MARK: - Derived stats

    var gamesNewestFirst: [Game] {
        games.sorted { $0.date > $1.date }
    }

    var gameCount: Int {
        games.count
    }

    var highScore: Int? {
        games.map(\.score).max()
    }

    var averageScore: Double? {
        guard !games.isEmpty else { return nil }
        let total = games.reduce(0) { $0 + $1.score }
        return Double(total) / Double(games.count)
    }

    /// Games bowled in the last seven days, counted from `now`.
    /// `now` is injectable so tests don't depend on the real clock.
    func gamesThisWeek(now: Date = .now, calendar: Calendar = .current) -> Int {
        guard let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) else { return 0 }
        return games.filter { $0.date >= weekAgo }.count
    }

    // MARK: - Actions

    /// Adds a game. Returns `false` and changes nothing if the score is out of range.
    @discardableResult
    func addGame(score: Int, location: String, date: Date = .now) -> Bool {
        guard Game.scoreRange.contains(score) else { return false }
        let trimmedLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
        let game = Game(
            date: date,
            location: trimmedLocation.isEmpty ? "Unknown lanes" : trimmedLocation,
            score: score
        )
        games.append(game)
        return true
    }

    func delete(_ game: Game) {
        games.removeAll { $0.id == game.id }
    }
}
