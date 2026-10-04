import SwiftUI

/// One game in the recent list: big score on the left, context on the right.
struct GameRow: View {
    let game: Game

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 16) {
            Text("\(game.score)")
                .font(.system(size: 34, weight: .black))
                .tracking(-1)
                .monospacedDigit()
                .foregroundStyle(game.isPerfect ? Color.brandAccent : .primary)
                .frame(width: 72, alignment: .leading)

            VStack(alignment: .leading, spacing: 2) {
                Text(game.location)
                    .font(.body.weight(.semibold))
                Text(game.date, format: .dateTime.weekday(.abbreviated).month(.abbreviated).day())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    List {
        GameRow(game: Game(location: "Lucky Strike", score: 212))
        GameRow(game: Game(location: "Bowlero", score: 300))
    }
    .listStyle(.plain)
}
