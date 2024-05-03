import CoreData
import SwiftUI

struct JobOfferListView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfSentCv, order: .reverse)])
    private var jobOffers: FetchedResults<JobOfferEntity>
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedJobOffer: JobOfferEntity?
    @State private var newOffer = false
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var tappedMenuButton: MenuButton = .edit

    let sections: [FilterCategory] = FilterCategory.allCases
    @State var selected: FilterCategory = .All

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
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    print(selectedJobOffer.debugDescription)
                    print(tappedMenuButton)
                } label: {
                    Text("Print")
                }
            }
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
        .onAppear {
            try? viewContext.save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { jobOffers[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately
                print("Failed to save the context: \(error.localizedDescription)")
            }
        }
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
        HorizontalFilterView(selectedItem: $selected, items: sections, itemsCount: jobOffers.count)
    }

    private var offerListView: some View {
        VStack(alignment: .leading, spacing: 0) {
            switch selected {
            case .All:
                List {
                    ForEach(jobOffers) { offer in
                        OfferCardView(
                            jobOffer: offer,
                            onTapOfferCard: {
                                selectedJobOffer = offer
                                tappedMenuButton = .edit
                            },
                            onTapThreeDotButton:
                                openMenu(for: offer))
                    }
                    .onDelete(perform: deleteItems)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)

            case .NoResponse:
                Text("No Response")
            case .Interview:
                Text("Interview")
            case .Accepted:
                Text("Accepted")
            case .Rejected:
                Text("Rejected")
            case .Archive:
                Text("Archive")
            }
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
            MenuOfferRowView(
                title: MenuRow.edit.title, icon: Image.menu.edit,
                action: {
                    selectedJobOffer = offer
                    tappedMenuButton = .edit
                }
            )

            // SECOND ROW - URL
            if let urlOffer = offer.offerUrl, !urlOffer.isEmpty {
                Group {
                    MenuOfferRowView(
                        title: MenuRow.url.title,
                        icon: Image.menu.web) {
                            UIApplication.shared.open(URL(string: urlOffer)!)
                        }
                }
            }

            // THIRD ROW - NOTES
            if let notes = offer.notes, !notes.isEmpty {
                Group {
                    MenuOfferRowView(
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
                    MenuOfferRowView(
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
    }
}

enum MenuButton {
    case notes, fulltext, edit
}
