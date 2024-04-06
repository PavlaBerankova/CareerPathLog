import CoreData
import SwiftUI

struct JobOfferTestViewCoreDataView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest<JobOfferEntity>(sortDescriptors: [SortDescriptor(\.dateOfSentCv)]) var jobOffers: FetchedResults

    var body: some View {
      NavigationView {
        List(jobOffers) { offer in
            OfferCardView(
            jobOffer: offer,
            overlayButtonAction: { })
        }
        .listStyle(.plain)
        .navigationTitle("Všechny CV")
      }
    }
}

#Preview {
    JobOfferTestViewCoreDataView()
    .environment(\.managedObjectContext, JobOfferContainer(forPreview: true).persistenContainer.viewContext)
}
