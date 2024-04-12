import CoreData
import SwiftUI

struct JobOfferTestViewCoreDataView: View {
  @Environment(\.managedObjectContext) var context
  @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfSentCv, order: .reverse)])
  private var jobOffers: FetchedResults<JobOfferEntity>

  @State private var showingAddView = false

  var body: some View {
    NavigationStack {
      List {
        ForEach(jobOffers) { offer in
          OfferCardView(jobOffer: offer)
            .overlay(
              NavigationLink {
                AddUpdateOfferView(jobOffer: offer)
              } label: {
                EmptyView()
              }
              // for hidden an arrow in NavigationLink
                .opacity(0)
            )
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .navigationTitle("Všechny CV")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add", systemImage: "plus") {
            showingAddView.toggle()
          }
        }
      }
      .sheet(isPresented: $showingAddView) {
        AddUpdateOfferView(jobOffer: nil)
      }
    }
  }
}

#Preview {
  JobOfferTestViewCoreDataView()
    .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
}
