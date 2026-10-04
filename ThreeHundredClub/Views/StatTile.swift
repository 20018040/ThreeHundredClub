import SwiftUI

/// A single large number with a small caption, used in the home screen grid.
struct StatTile: View {
    let title: String
    let value: String
    var isHighlighted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(value)
                .font(.system(size: 44, weight: .black))
                .tracking(-1)
                .monospacedDigit()
                .minimumScaleFactor(0.6)
                .lineLimit(1)
                .foregroundStyle(isHighlighted ? .white : .primary)
            Text(title.uppercased())
                .font(.caption.weight(.bold))
                .tracking(1)
                .foregroundStyle(isHighlighted ? .white.opacity(0.85) : .secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(
            isHighlighted ? Color.brandAccent : Color(.systemGray6),
            in: RoundedRectangle(cornerRadius: 20)
        )
    }
}

#Preview {
    HStack {
        StatTile(title: "Average", value: "189", isHighlighted: true)
        StatTile(title: "High score", value: "300")
    }
    .padding()
}
