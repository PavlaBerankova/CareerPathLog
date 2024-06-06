import CoreData
import SwiftUI

struct JobOfferListView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfSentCv, order: .reverse)],
                  predicate: NSPredicate(value: true)
    )
    private var jobOffers: FetchedResults<JobOfferEntity>
    @EnvironmentObject var coordinator: Coordinator
    @State private var selectedJobOffer: JobOfferEntity?
    @State private var newOffer = false
    @State private var showNotes = false
    @State private var showFulltextOffer = false
    @State private var tappedMenuButton: MenuButton = .edit
    @State var selectedCategory: Status = .allStatus
    @State private var allJobOffers: [JobOfferEntity] = []

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
        .onAppear {
            allJobOffers = Array(jobOffers)
            print(allJobOffers.count)
            try? viewContext.save()
        }
        .onChange(of: selectedCategory) { _ in
            updatePredicate()
        }
    }

    private func updatePredicate() {
            switch selectedCategory {
            case .allStatus:
                jobOffers.nsPredicate = NSPredicate(value: true)
            case .noResponse:
                jobOffers.nsPredicate = NSPredicate(format: "status == %@", Status.noResponse.rawValue)
            case .interview:
                jobOffers.nsPredicate = NSPredicate(format: "status == %@", Status.interview.rawValue)
            case .accepted:
                jobOffers.nsPredicate = NSPredicate(format: "status == %@", Status.accepted.rawValue)
            case .rejected:
                jobOffers.nsPredicate = NSPredicate(format: "status == %@", Status.rejected.rawValue)
            case .archive:
                jobOffers.nsPredicate = NSPredicate(format: "status == %@", Status.archive.rawValue)
            }
        }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { jobOffers[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
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
      HorizontalFilterView(
        selectedFilter: $selectedCategory,
        count: computeStatusCounts())
    }

    private func computeStatusCounts() -> [Status: Int] {
            var counts = [Status: Int]()
        counts[.allStatus] = allJobOffers.filter { $0.archive == false }.count
            counts[.noResponse] = allJobOffers.filter { $0.viewStatus == .noResponse }.count
            counts[.interview] = allJobOffers.filter { $0.viewStatus == .interview }.count
            counts[.accepted] = allJobOffers.filter { $0.viewStatus == .accepted }.count
            counts[.rejected] = allJobOffers.filter { $0.viewStatus == .rejected }.count
        counts[.archive] = allJobOffers.filter { $0.archive == true }.count
            return counts
        }

    private var offerListView: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                ForEach(jobOffers) { offer in
                    OfferCardView(
                        jobOffer: offer,
                        onTapOfferCard: {
                            selectedJobOffer = offer
                            tappedMenuButton = .edit
                        },
                        onTapThreeDotButton: openMenu(for: offer))
                }
                .onDelete(perform: deleteItems)
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
    }
}

enum MenuButton {
    case notes, fulltext, edit
}
