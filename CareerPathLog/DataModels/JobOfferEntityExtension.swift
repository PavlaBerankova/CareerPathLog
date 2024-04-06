import Foundation
import SwiftUI

extension JobOfferEntity {
  var viewCompanyName: String {
    companyName ?? ""
  }

  var viewJobTitle: String {
    jobTitle ?? ""
  }

  var viewOfferUrl: String {
   offerUrl ?? ""
  }

  var viewSalary: String {
    salary ?? ""
  }

  var viewNotes: String {
      notes ?? ""
  }

  var viewDateOfSentCv: String {
      dateOfSentCv?.formattedDate() ?? ""
  }

  var viewDateOfFirstRoundOfInterview: Date {
    dateOfFirstRounOfInterview ?? Date()
  }

  var viewDateOfSecondRoundOfInterview: Date {
    dateOfSecondRoundOfInterview ?? Date()
  }

  var viewDateOfThirdRoundOfInterview: Date {
    dateOfThirdRoundOfInterview ?? Date()
  }

  var viewFullTextOffer: String {
    fullTextOffer ?? ""
  }

  //////////////////////
  var status: Status {
    .noResponse
  }
  //////////////////////

  var viewNumberOfDaysSinceSubmittedCv: Int {
    let calendar = Calendar.current
      let componenets = calendar.dateComponents([.day], from: dateOfSentCv ?? Date())
    return abs(componenets.day!)
  }

  var viewStatusText: LocalizedStringKey {
      if response {
          switch status {
          case .noResponse:
              return "\(viewNumberOfDaysSinceSubmittedCv) days without response"
          case .interview:
              return "interview"
          case .rejected:
              return "rejected"
          case .accepted:
              return "accepted"
          case .allStatus:
              return "all submitted CV"
          }
      } else {
          return "\(viewNumberOfDaysSinceSubmittedCv) days without response"
      }
  }
  var statusSubtitle: LocalizedStringResource? {
      if response && status == .interview {
              if firstRoundOfInterview && secondRoundOfInterview && thirdRoundOfInterview {
                  return "3. round"
              } else if firstRoundOfInterview && secondRoundOfInterview {
                  return "2. round"
              } else if firstRoundOfInterview {
                  return "1. round"
              }
          }
          return nil
  }
}
