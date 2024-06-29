import CoreData
import SwiftUI

struct JobOfferListView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var data: PersistenceController
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedJobOffer: JobOfferEntity?
    @State private var newOffer = false
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var tappedMenuButton: MenuButton = .edit
    @State var selectedCategory: Status = .allStatus

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            topBarFilter
            Spacer()
            offerListView
            Spacer()
        }
        .ignoresSafeArea(edges: .bottom)
        .toolbar {
            addButton
            topBarMenu
        }
        .toolbarBackground(.hidden, for: .bottomBar)
        .sheet(isPresented: $newOffer) {
            coordinator.addUpdateOfferView(with: nil)
        }
        .sheet(item: $selectedJobOffer) { offer in
            switch tappedMenuButton {
            case .notes:
                coordinator.infoText(with: offer.notes)
            case .fulltext:
                coordinator.infoText(with: offer.fullTextOffer)
            case .edit:
                coordinator.addUpdateOfferView(with: offer)
            }
        }
        .presentationDragIndicator(.visible)
    }
}

// MARK: - EXTENSION
extension JobOfferListView {
    private var topBarMenu: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Section {
                    Text("Choose Language")
                        .foregroundStyle(.accent)
                }
                Button(action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }) {
                    Label("Czech", image: "czech-republic")
                }
                Button(action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }) {
                    Label("English", image: "united-kingdom")
                }
            } label: {
                Image(systemName: "line.3.horizontal")
            }
        }
    }

    private var topBarFilter: some View {
        HorizontalFilterView(selectedFilter: $selectedCategory)
    }

    private var offerListView: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                ForEach(data.filterOffer(by: selectedCategory)) { offer in
                    OfferCardView(
                        jobOffer: offer,
                        onTapOfferCard: {
                            selectedJobOffer = offer
                            tappedMenuButton = .edit
                        },
                        onTapThreeDotButton: openMenu(for: offer))
                }
                .onDelete(perform: data.deleteItem)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }

    private var addButton: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button {
                newOffer.toggle()
            } label: {
                Image(systemName: "plus.circle.fill", variableValue: 1.00)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.white, Color.clear, Color.black)
                    .font(.system(size: 48, weight: .light))
            }
        }
    }

    func openMenu(for offer: JobOfferEntity) -> some View {
        Group {
            // FIRST ROW - EDIT
            ItemMenuRowView(
                title: OfferMenuRow.edit.title, icon: Image.menu.edit,
                action: {
                    selectedJobOffer = offer
                    tappedMenuButton = .edit
                }
            )

            // SECOND ROW - URL
            if let urlOffer = offer.offerUrl, !urlOffer.isEmpty {
                Group {
                    ItemMenuRowView(
                        title: OfferMenuRow.url.title,
                        icon: Image.menu.web) {
                            UIApplication.shared.open(URL(string: urlOffer)!)
                        }
                }
            }

            // THIRD ROW - NOTES
            if let notes = offer.notes, !notes.isEmpty {
                Group {
                    ItemMenuRowView(
                        title: OfferMenuRow.notes.title,
                        icon: Image.menu.notes) {
                            selectedJobOffer = offer
                            tappedMenuButton = .notes
                        }
                }
            }

            // FOURTH ROW - FULLTEXT
            if let fulltextOffer = offer.fullTextOffer, !fulltextOffer.isEmpty {
                Group {
                    ItemMenuRowView(
                        title: OfferMenuRow.fullText.title,
                        icon: Image.menu.document) {
                            selectedJobOffer = offer
                            tappedMenuButton = .fulltext
                        }
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationStack {
        JobOfferListView()
            .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
            .environmentObject(Coordinator())
            .environmentObject(PersistenceController())
    }
}
