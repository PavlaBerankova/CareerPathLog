import SwiftUI

struct OfferCardView: View {
    // MARK: PROPERTIES
    let date = Date.now
    let companyName: String
    let jobTitle: String
    let urlOffer: String?
    let dateOfSentCV: Date
    var numberOfDaysSinceSendingCv: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date.now, to: dateOfSentCV)
        return abs(components.day!)
    }
    let notes: String?
    var backgroundColor: Color {
        if numberOfDaysSinceSendingCv <= 14 {
            return Color.gray.opacity(0.7)
        }
        return Color("Third")
    }

    // MARK: - BODY
    var body: some View {
//            RoundedRectangle(cornerRadius: 20)
//                //.background(backgroundColor)
//                .foregroundStyle(.gray.opacity(0.1))
//                .shadow(color: backgroundColor, radius: 10)
//                .frame(maxWidth: .infinity)
//                .frame(height: 260)

            LazyVStack(alignment: .leading) {
                HStack {
                    Text("\(dateOfSentCV.formatted(.dateTime.day().month()))\n\(dateOfSentCV.formatted(.dateTime.year()))")
                        .bold()
                        .foregroundStyle(Color("Fourth"))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 0)
                            .border(.black)
                            .foregroundStyle(.clear)
                        )


                    VStack(alignment: .leading) {
                        Text(companyName)
                            .font(.title)
                            .foregroundStyle(Color("Fourth"))
                        Text(jobTitle)
                            .foregroundStyle(Color("Fourth"))
                    }
                    .padding(.leading, 20)
                }
                VStack(alignment: .leading, spacing: 10) {
                    if let urlOffer = urlOffer {
                        Link("Přejít na inzerát", destination: URL(string: urlOffer)!)
                            .foregroundStyle(Color.black)
                    }
                    Text("Počet dní od odeslání: \(numberOfDaysSinceSendingCv)") 
                        .foregroundStyle(Color("Fourth")) // computed
                    if let notes = notes {
                        Text("Poznámka: " + notes)
                            .foregroundStyle(Color("Fourth"))// notes (model)
                    }

                    HStack {
                        Button {
                            print(Date.now)
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .foregroundStyle(.white)
                                .overlay {
                                    Text("Upravit")
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }

                        }
                        Button {

                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity)
                                .frame(height: 30)
                                .foregroundStyle(.white)
                                .overlay {
                                    Text("Detail")
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                }
                        }
                    }

                }
                .padding(.top)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(backgroundColor.opacity(0.8))
            )
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        OfferCardView(companyName: "Futured", jobTitle: "iOS vývojář", urlOffer: "https://www.futured.app/job/ios-developer/", dateOfSentCV: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1))!, notes: "stáž")
    }
    .padding(.horizontal)
}
