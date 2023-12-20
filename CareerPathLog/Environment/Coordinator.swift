import SwiftUI

final class Coordinator: ObservableObject {
    var addOfferView: some View {
        FormOfferView()
            .presentationDragIndicator(.visible)
    }

    func offerInfo(with text: String?, type: String) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let text = text, !text.isEmpty {
                    Text(text)
                        .padding(25)
                } else {
                    VStack(spacing: 50) {
                        Text(type == "notes" ? "Žádné poznámky" : "Text inzerátu chybí")
                            .bold()
                        Image(systemName: type == "notes" ? Image.info.notes : Image.info.document)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .font(.title)
                    .opacity(0.2)
                    .padding()
                }
            }
            .padding(.top, 50)
        }
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium, .large])
    }
}
