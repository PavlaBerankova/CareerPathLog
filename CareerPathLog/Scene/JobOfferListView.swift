import CoreData
import SwiftUI

struct JobOfferListView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfSentCv, order: .reverse)])
    private var jobOffers: FetchedResults<JobOfferEntity>
    @EnvironmentObject var coordinator: Coordinator

    @State private var showingAddUpdateView = false
    @State var selectedJobOffer: JobOfferEntity?

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
            }
            .toolbarBackground(.hidden, for: .bottomBar)
            .sheet(item: $selectedJobOffer) { offer in
                coordinator.addUpdateOfferView(with: offer)
            }
            .presentationDragIndicator(.visible)
            .onAppear {
                try? viewContext.save()
                print(selectedJobOffer)
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

    private func changeStatus(_ offer: JobOfferEntity) {
        self.selectedJobOffer = offer // Set the offer first
        print(selectedJobOffer)
    }

    private func openMenu(for offer: JobOfferEntity) -> some View {
        Group {
            // FIRST ROW - EDIT
            CustomMenuRowView(title: MenuItemRow.edit.title, icon: Image.menu.edit, action: {
                showingAddUpdateView.toggle()
                selectedJobOffer = offer
            })

            // SECOND ROW - URL
            CustomMenuRowView(title: MenuItemRow.url.title, icon: Image.menu.web, action: {
                selectedJobOffer = offer
                if let urlOffer = selectedJobOffer?.viewOfferUrl, !urlOffer.isEmpty {
                    UIApplication.shared.open(URL(string: urlOffer)!)
                } else {
                    //                    alertTitle = AlertTitle.url.title
                    //                    showingAlert.toggle()
                }
            })

            // THIRD ROW - NOTES
            CustomMenuRowView(title: MenuItemRow.notes.title, icon: Image.menu.notes, action: {
                selectedJobOffer = offer
                if let notes = selectedJobOffer?.viewNotes, !notes.isEmpty {
                    // showNotes.toggle()
                } else {
                    //                    alertTitle = AlertTitle.notes.title
                    //                    showingAlert.toggle()
                }
            })

            // FOURTH ROW - FULLTEXT
            CustomMenuRowView(title: MenuItemRow.fullText.title, icon: Image.menu.document, action: {
                selectedJobOffer = offer
                if let fulltext = selectedJobOffer?.viewFullTextOffer, !fulltext.isEmpty {
                    // showFulltextOffer.toggle()
                } else {
                    //                    alertTitle = AlertTitle.fulltext.title
                    //                    showingAlert.toggle()
                }
            })
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
                                changeStatus(offer)
                            },
                            onTapThreeDotButton: openMenu(for: offer))
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
                NavigationLink {
                    coordinator.addUpdateOfferView(with: nil)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.black)
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
