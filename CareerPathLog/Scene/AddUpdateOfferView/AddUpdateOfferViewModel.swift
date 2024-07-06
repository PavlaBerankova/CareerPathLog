//
//  AddUpdateJobOfferViewModel.swift
//  CareerPathLog
//
//  Created by Pavla Beránková on 12.06.2024.
//

import SwiftUI

protocol JobOfferProtocol {
    var companyName: String { get }
    var jobTitle: String { get }
    var offerUrl: String { get }
    var salary: String { get }
    var jobLocation: String { get }
    var jobLevel: JobLevel { get }
    var typesOfEmployment: TypesOfEmployment { get }
    var workingArrangements: WorkingArrangements { get }
    var dateOfSentCv: Date { get }
    var response: Bool { get }
    var dateOfResponse: Date { get }
    var status: Status { get }
    var firstRoundOfInterview: Bool { get }
    var dateOfFirstRoundOfInterview: Date { get }
    var secondRoundOfInterview: Bool { get }
    var dateOfSecondRoundOfInterview: Date { get }
    var thirdRoundOfInterview: Bool { get }
    var dateOfThirdRoundOfInterview: Date { get }
    var notes: String { get }
    var fullTextOffer: String { get }
    var isArchived: Bool { get }
}

final class AddUpdateOfferViewModel: ObservableObject {
    struct JobOffer: JobOfferProtocol {
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

    @Published var content: JobOffer = .emptyForm()
    @Published var showingAlert = false
    @Published var showingAlertDelete = false
    @Published var alertMessage = LocalizedStringKey(String())

    init() { }

    func companyAndJobTitleTextFieldIsNotEmpty() -> Bool {
        if content.companyName.isEmpty && content.jobTitle.isEmpty {
            alertMessage = LocalizedStringKey("You must fill Company name and Job title field.")
            return false
        } else if content.companyName.isEmpty {
            alertMessage = LocalizedStringKey("You must fill Company name field.")
            return false
        } else if content.jobTitle.isEmpty {
            alertMessage = LocalizedStringKey("You must fill Job title field.")
            return false
        }
        alertMessage = LocalizedStringKey(String())
        return true
    }
}

extension AddUpdateOfferViewModel.JobOffer {
    static func emptyForm() -> AddUpdateOfferViewModel.JobOffer {
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

