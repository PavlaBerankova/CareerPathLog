import CoreData
import SwiftUI

struct JobOfferListView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var model: PersistenceController
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
                    Text("Menu and Settings")
                }
                Section {
                    Text("Statistics")
                    Text("Profile")
                    Text("Language")
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
                ForEach(model.filterOffer(by: selectedCategory)) { offer in
                    OfferCardView(
                        jobOffer: offer,
                        onTapOfferCard: {
                            selectedJobOffer = offer
                            tappedMenuButton = .edit
                        },
                        onTapThreeDotButton: openMenu(for: offer))
                }
                .onDelete(perform: model.deleteItem)
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
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 55, height: 55)
                    .foregroundStyle(Color.black)
            }
        }
    }

    func openMenu(for offer: JobOfferEntity) -> some View {
        Group {
            // FIRST ROW - EDIT
            ItemMenuRowView(
                title: MenuRow.edit.title, icon: Image.menu.edit,
                action: {
                    selectedJobOffer = offer
                    tappedMenuButton = .edit
                }
            )

            // SECOND ROW - URL
            if let urlOffer = offer.offerUrl, !urlOffer.isEmpty {
                Group {
                    ItemMenuRowView(
                        title: MenuRow.url.title,
                        icon: Image.menu.web) {
                            UIApplication.shared.open(URL(string: urlOffer)!)
                        }
                }
            }

            // THIRD ROW - NOTES
            if let notes = offer.notes, !notes.isEmpty {
                Group {
                    ItemMenuRowView(
                        title: MenuRow.notes.title,
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
                        title: MenuRow.fullText.title,
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
