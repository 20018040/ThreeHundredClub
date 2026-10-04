import Foundation

/// One bowling game.
///
/// For now a game is just a final score with some context. Frame-by-frame data
/// arrives in a later stage; stats will be derived from frames rather than stored.
struct Game: Identifiable, Hashable {
    let id: UUID
    var date: Date
    var location: String
    var score: Int

    /// Bowling scores are bounded: a gutter-only game is 0, a perfect game is 300.
    static let scoreRange = 0...300
    static let perfectScore = 300

    init(id: UUID = UUID(), date: Date = .now, location: String, score: Int) {
        self.id = id
        self.date = date
        self.location = location
        self.score = score
    }

    var isPerfect: Bool {
        score == Game.perfectScore
    }
}
