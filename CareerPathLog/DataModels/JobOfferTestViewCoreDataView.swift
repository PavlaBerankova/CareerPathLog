import CoreData
import SwiftUI

struct JobOfferTestViewCoreDataView: View {
  @FetchRequest<JobOfferEntity>(sortDescriptors: []) var jobOffers: FetchedResults

    var body: some View {
      NavigationView {
        List(jobOffers) { offer in
          Text(offer.companyName ?? "Company name placeholder")
        }
        .font(.title)
      }
    }
}

#Preview {
    JobOfferTestViewCoreDataView()
    .environment(\.managedObjectContext, JobOfferContainer(forPreview: true).persistenContainer.viewContext)
}
