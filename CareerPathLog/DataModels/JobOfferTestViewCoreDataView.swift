import CoreData
import SwiftUI

struct JobOfferTestViewCoreDataView: View {
  @Environment(\.managedObjectContext) var viewContext
  @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfSentCv, order: .reverse)])
  private var jobOffers: FetchedResults<JobOfferEntity>

  @State private var showingAddUpdateView = false
  @State private var newOffer = false
  @State private var selectedJobOffer: JobOfferEntity? = nil

  var body: some View {
    NavigationStack {
      List {
        ForEach(jobOffers) { offer in
              OfferCardView(
                jobOffer: offer,
                onTapOfferCard: {
                    newOffer = false
                    selectedJobOffer = offer
                    showingAddUpdateView.toggle()
                },
                onTapThreeDotButton: openMenu(for: offer))
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .navigationTitle("Všechny CV")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add", systemImage: "plus") {
            newOffer = true
            selectedJobOffer = nil
            showingAddUpdateView.toggle()
          }
        }
      }
      .sheet(isPresented: $showingAddUpdateView) {
          AddUpdateOfferView(jobOffer: newOffer ? nil : selectedJobOffer)
      }
      .onAppear {
         try? viewContext.save()
      }
    }
  }

    private func showAddUpdateView(with offer: JobOfferEntity) {

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

#Preview {
  JobOfferTestViewCoreDataView()
    .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
}
