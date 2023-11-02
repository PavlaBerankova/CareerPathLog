import SwiftUI

struct AddCompanyView: View {
    // MARK: PROPERTIES
    @State private var companyName = String()
    @State private var jobTitle = String()
    @State private var urlOffer = String()
    @State private var notes = String()

    @State private var dateOfSentCV = Date()
    @State private var dateOfReply = Date()
    @State private var dateOfFirstRoundOfInterview = Date()
    @State private var dateOfSecondRoundOfInterview = Date()

    @State private var shouldWorkRemotely = false

    @State private var fullTextOffer = String()
    let startingDate = Date.distantPast
    let endingDate = Date.distantFuture

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Název firmy", text: $companyName)
                    TextField("Název pozice", text: $jobTitle)
                    TextField("URL inzerátu", text: $urlOffer)
                    TextField("Poznámka", text: $notes)
                } header: {
                    Text("Info")
                }

                Toggle("Možnost remote", isOn: $shouldWorkRemotely)
                    .tint(Color("LogScreenBackground"))

                Section {
                    DatePicker(
                        selection: $dateOfSentCV,
                        in: startingDate...endingDate,
                        displayedComponents: .date) {
                            Text("Odeslané CV")
                        }
                    DatePicker(
                        selection: $dateOfReply,
                        in: startingDate...endingDate,
                        displayedComponents: .date) {
                            Text("Odpověď")
                        }
                    DatePicker(
                        selection: $dateOfFirstRoundOfInterview,
                        in: startingDate...endingDate,
                        displayedComponents: .date) {
                            Text("1. kolo pohovoru")
                        }
                    DatePicker(
                        selection: $dateOfSecondRoundOfInterview,
                        in: startingDate...endingDate,
                        displayedComponents: .date) {
                            Text("2. kolo pohovoru")
                        }
                } header: {
                    Text("Datum")
                }
                .tint(Color("LogScreenBackground"))




                Section {
                    TextEditor(text: $fullTextOffer)
                } header: {
                    Text("Celý text inzerátu")
                }

            }
            .navigationTitle("Přidat záznam")

        }
    }
}

// MARK: - PREVIEW
#Preview {
    AddCompanyView()
}
