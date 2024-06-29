//
//  JobOfferEntityConverter.swift
//  CareerPathLog
//
//  Created by Pavla Beránková on 28.06.2024.
//

import SwiftUI

struct JobOfferEntityConverter {
    static func convert(model: AddUpdateOfferViewModel.JobOffer) -> JobOfferEntity {
        return JobOfferEntity(
            companyName: model.companyName,
            jobTitle: model.jobTitle,
            offerUrl: model.offerUrl,
            salary: model.salary,
            notes: model.notes,
            dateOfSentCv: model.dateOfSentCv,
            response: model.response,
            dateOfResponse: model.dateOfResponse,
            firstRoundOfInterview: model.firstRoundOfInterview,
            dateOfFirstRoundOfInterview: model.dateOfFirstRoundOfInterview,
            secondRoundOfInterview: model.secondRoundOfInterview,
            dateOfSecondRoundOfInterview: model.dateOfSecondRoundOfInterview,
            thirdRoundOfInterview: model.thirdRoundOfInterview,
            dateOfThirdRoundOfInterview: model.dateOfThirdRoundOfInterview,
            fullTextOffer: model.fullTextOffer,
            status: model.status.rawValue,
            jobLocation: model.jobLocation,
            jobLevel: model.jobLevel.rawValue,
            typesOfEmployment: model.typesOfEmployment.rawValue,
            workingArrangements: model.workingArrangements.rawValue,
            isArchived: model.isArchived)
    }

    static func convert(model: JobOfferEntity) -> AddUpdateOfferViewModel.JobOffer {
        return AddUpdateOfferViewModel.JobOffer(
            companyName: model.viewCompanyName,
            jobTitle: model.viewJobTitle,
            offerUrl: model.viewOfferUrl,
            salary: model.viewSalary,
            jobLocation: model.viewJobLocation,
            jobLevel: model.viewJobLevel,
            typesOfEmployment: model.viewTypesOfEmployment,
            workingArrangements: model.viewWorkingArrangements,
            response: model.response,
            dateOfResponse: model.dateOfResponse ?? Date(),
            status: model.viewStatus,
            firstRoundOfInterview: model.firstRoundOfInterview,
            dateOfFirstRoundOfInterview: model.viewDateOfFirstRoundOfInterview,
            secondRoundOfInterview: model.secondRoundOfInterview,
            dateOfSecondRoundOfInterview: model.viewDateOfSecondRoundOfInterview,
            thirdRoundOfInterview: model.thirdRoundOfInterview,
            dateOfThirdRoundOfInterview: model.viewDateOfThirdRoundOfInterview,
            notes: model.viewNotes,
            fullTextOffer: model.viewFullTextOffer,
            isArchived: model.isArchived)
       }
}
