import CoreData
import SwiftUI

struct JobOfferTestViewCoreDataView: View {
  @Environment(\.managedObjectContext) var viewContext
  @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfSentCv, order: .reverse)])
  private var jobOffers: FetchedResults<JobOfferEntity>

  @State private var showingAddView = false

  var body: some View {
    NavigationStack {
      List {
        ForEach(jobOffers) { offer in
          NavigationLink {
            AddUpdateOfferView(jobOffer: offer)
          } label: {
              OfferCardView(
                jobOffer: offer,
                threeDotButtonAction: { print("Tap on three dot button") },
                contentMenu: Text("Menu"))
//              OfferCardView(
//                jobOffer: offer,
//                contentMenu: {
//                    print("Tap on three button")
//                })
          }
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
      .onAppear {
         try? viewContext.save()
      }
    }
  }
}

#Preview {
  JobOfferTestViewCoreDataView()
    .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
}
