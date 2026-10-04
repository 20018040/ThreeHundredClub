import SwiftUI

/// Sheet for manually entering a finished game.
struct AddGameView: View {
    let viewModel: GameListViewModel

    @Environment(\.dismiss) private var dismiss
    @State private var scoreText = ""
    @State private var location = ""
    @State private var date = Date.now
    @FocusState private var isScoreFocused: Bool

    /// Text fields work in strings; the model wants an Int. `nil` means "not a number".
    private var parsedScore: Int? {
        Int(scoreText.trimmingCharacters(in: .whitespaces))
    }

    private var isValid: Bool {
        guard let score = parsedScore else { return false }
        return Game.scoreRange.contains(score)
    }

    private var showsValidationHint: Bool {
        !scoreText.isEmpty && !isValid
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Score") {
                    TextField("0 to 300", text: $scoreText)
                        .keyboardType(.numberPad)
                        .font(.system(size: 44, weight: .black))
                        .monospacedDigit()
                        .focused($isScoreFocused)
                    if showsValidationHint {
                        Text("Enter a whole number from 0 to 300.")
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }

                Section("Details") {
                    TextField("Bowling center", text: $location)
                        .textInputAutocapitalization(.words)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("New Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .fontWeight(.bold)
                        .disabled(!isValid)
                }
            }
            .onAppear { isScoreFocused = true }
        }
    }

    private func save() {
        guard let score = parsedScore else { return }
        viewModel.addGame(score: score, location: location, date: date)
        dismiss()
    }
}

#Preview {
    AddGameView(viewModel: GameListViewModel())
}
