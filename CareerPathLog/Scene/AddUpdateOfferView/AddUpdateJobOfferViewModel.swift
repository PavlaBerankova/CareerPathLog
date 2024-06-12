//
//  AddUpdateJobOfferViewModel.swift
//  CareerPathLog
//
//  Created by Pavla Beránková on 12.06.2024.
//

import SwiftUI

final class AddUpdateJobOfferViewModel: ObservableObject {
    init() { }

     func validateTextField(_ companyName: String, _ jobTitle: String) -> (message: LocalizedStringKey, isNotEmpty: Bool) {
        if companyName.isEmpty && jobTitle.isEmpty {
            return (LocalizedStringKey("You must fill Company name and Job title field."), false)
        } else if companyName.isEmpty {
            return (LocalizedStringKey("You must fill Company name field."), false)
        } else if jobTitle.isEmpty {
            return (LocalizedStringKey("You must fill Job title field."), false)
        }
        return ("", true)
    }
}
