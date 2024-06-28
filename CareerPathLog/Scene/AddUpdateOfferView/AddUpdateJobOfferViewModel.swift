//
//  AddUpdateJobOfferViewModel.swift
//  CareerPathLog
//
//  Created by Pavla Beránková on 12.06.2024.
//

import SwiftUI

final class AddUpdateJobOfferViewModel: ObservableObject {
    struct JobOffer {
        var companyName: String
        var jobTitle: String
        var offerUrl: String
        var salary: String
        var jobLocation: String
        var jobLevel: JobLevel = .none
        var typesOfEmployment: TypesOfEmployment = .none
        var workingArrangements: WorkingArrangements = .none
        var dateOfSentCv = Date.now
        var response = false
        var dateOfResponse = Date.now
        var status: Status = .noResponse
        var firstRoundOfInterview = false
        var dateOfFirstRoundOfInterview = Date.now
        var secondRoundOfInterview = false
        var dateOfSecondRoundOfInterview = Date.now
        var thirdRoundOfInterview = false
        var dateOfThirdRoundOfInterview = Date.now
        var notes: String
        var fullTextOffer: String
        var isArchived: Bool = false

        init(
            companyName: String,
            jobTitle: String,
            offerUrl: String,
            salary: String,
            jobLocation: String,
            jobLevel: JobLevel,
            typesOfEmployment: TypesOfEmployment,
            workingArrangements: WorkingArrangements,
            dateOfSentCv: Date = Date.now,
            response: Bool,
            dateOfResponse: Date,
            status: Status,
            firstRoundOfInterview: Bool,
            dateOfFirstRoundOfInterview: Date,
            secondRoundOfInterview: Bool,
            dateOfSecondRoundOfInterview: Date,
            thirdRoundOfInterview: Bool,
            dateOfThirdRoundOfInterview: Date,
            notes: String,
            fullTextOffer: String,
            isArchived: Bool) {
                self.companyName = companyName
                self.jobTitle = jobTitle
                self.offerUrl = offerUrl
                self.salary = salary
                self.jobLocation = jobLocation
                self.jobLevel = jobLevel
                self.typesOfEmployment = typesOfEmployment
                self.workingArrangements = workingArrangements
                self.dateOfSentCv = dateOfSentCv
                self.response = response
                self.dateOfResponse = dateOfResponse
                self.status = status
                self.firstRoundOfInterview = firstRoundOfInterview
                self.dateOfFirstRoundOfInterview = dateOfFirstRoundOfInterview
                self.secondRoundOfInterview = secondRoundOfInterview
                self.dateOfSecondRoundOfInterview = dateOfSecondRoundOfInterview
                self.thirdRoundOfInterview = thirdRoundOfInterview
                self.dateOfThirdRoundOfInterview = dateOfThirdRoundOfInterview
                self.notes = notes
                self.fullTextOffer = fullTextOffer
                self.isArchived = isArchived
            }
    }

    @Published var content: JobOffer = .makeMock()
    @Published var showingAlert = false
    @Published var showingAlertDelete = false
    @Published var alertMessage = LocalizedStringKey(String())

    init() { }

    func companyAndJobTitleTextFieldIsNotEmpty() -> Bool {
        if content.companyName.isEmpty && content.jobTitle.isEmpty {
            alertMessage = LocalizedStringKey("You must fill Company name and Job title field.")
            return false
            //return (LocalizedStringKey("You must fill Company name and Job title field."), false)
        } else if content.companyName.isEmpty {
            alertMessage = LocalizedStringKey("You must fill Company name field.")
            return false
            //return (LocalizedStringKey("You must fill Company name field."), false)
        } else if content.jobTitle.isEmpty {
            alertMessage = LocalizedStringKey("You must fill Job title field.")
            return false
            // return (LocalizedStringKey("You must fill Job title field."), false)
        }
        alertMessage = LocalizedStringKey(String())
        return true
    }
}

extension AddUpdateJobOfferViewModel.JobOffer {
    static func makeMock() -> AddUpdateJobOfferViewModel.JobOffer {
        .init(
            companyName: String(),
            jobTitle: String(),
            offerUrl: String(),
            salary: String(),
            jobLocation: String(),
            jobLevel: .none,
            typesOfEmployment: .none,
            workingArrangements: .none,
            response: false,
            dateOfResponse: Date.now,
            status: .noResponse,
            firstRoundOfInterview: false,
            dateOfFirstRoundOfInterview: Date.now,
            secondRoundOfInterview: false,
            dateOfSecondRoundOfInterview: Date.now,
            thirdRoundOfInterview: false,
            dateOfThirdRoundOfInterview: Date.now,
            notes: String(),
            fullTextOffer: String(),
            isArchived: false
        )
    }
}

