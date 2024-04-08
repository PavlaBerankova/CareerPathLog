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

  var viewDateOfSentCv: Date {
    dateOfSentCv ?? Date()
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

  var viewStatus: Status {
    get {
      return Status(rawValue: String(self.status ?? "No response")) ?? .noResponse
    }
    set {
      self.status = String(newValue.rawValue)
    }
  }

  var viewNumberOfDaysSinceSubmittedCv: Int {
    let calendar = Calendar.current
    let componenets = calendar.dateComponents([.day], from: viewDateOfSentCv)
    return abs(componenets.day!)
  }

  var viewStatusText: LocalizedStringKey {
      if response {
          switch viewStatus {
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
      if response && viewStatus == .interview {
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
