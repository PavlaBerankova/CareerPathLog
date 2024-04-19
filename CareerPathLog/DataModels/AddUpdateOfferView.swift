import CoreData
import SwiftUI

struct AddUpdateOfferView: View {
    // MARK: - PROPERTIES
    let jobOffer: JobOfferEntity?

    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var companyName = String()
    @State private var jobTitle = String()
    @State private var offerUrl = String()
    @State private var salary = String()
    @State private var jobLocation = String()
    @State private var jobLevel: JobLevel = .none

    @State private var dateOfSentCv = Date()
    @State private var response = true
    @State private var dateOfResponse = Date()
    @State private var status: Status = .noResponse

    @State private var firstRoundOfInterview = false
    @State private var dateOfFirstRoundOfInterview = Date()
    @State private var secondRoundOfInterview = false
    @State private var dateOfSecondRoundOfInterview = Date()
    @State private var thirdRoundOfInterview = false
    @State private var dateOfThirdRoundOfInterview = Date()

    @State private var notes = String()
    @State private var fullTextOffer = String()

    let startDate = Date.distantPast
    let endDate = Date.distantFuture
    let dateOfInterview: LocalizedStringKey = "    Date of interview"

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Company name", text: $companyName)
                    TextField("Job title", text: $jobTitle)
                    TextField("URL offer", text: $offerUrl)
                    TextField("Salary", text: $salary)
                    TextField("Job location", text: $jobLocation)
                    Picker("Job level", selection: $jobLevel) {
                        Text("junior").tag(JobLevel.junior)
                        Text("medior").tag(JobLevel.medior)
                        Text("senior").tag(JobLevel.senior)
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Info")
                }

                Section {
                    DatePicker(
                        selection: $dateOfSentCv,
                        in: startDate...endDate,
                        displayedComponents: .date) {
                            Text("Date of submitted CV")
                        }
                    Toggle("Response", isOn: $response)
                    if response {
                        DatePicker(
                            selection: $dateOfResponse,
                            in: startDate...endDate,
                            displayedComponents: .date) {
                                Text("Date of response")
                            }

                        Section {
                            Picker("Type of response", selection: $status) {
                                Text(LocalizedStringKey("StatusPicker - no response"))
                                    .tag(Status.noResponse)
                                Text(LocalizedStringKey("StatusPicker - interview"))
                                    .tag(Status.interview)
                                Text(LocalizedStringKey("StatusPicker - accepted"))
                                    .tag(Status.accepted)
                                Text(LocalizedStringKey("StatusPicker - rejected"))
                                    .tag(Status.rejected)
                            }
                            .pickerStyle(.menu)
                        }

                        if status == .interview {
                            Section {
                                Toggle("1. round of interview", isOn: $firstRoundOfInterview)
                                if firstRoundOfInterview {
                                    DatePicker(
                                        selection: $dateOfFirstRoundOfInterview,
                                        in: startDate...endDate,
                                        displayedComponents: .date) {
                                            Text(dateOfInterview)
                                        }
                                }

                                Toggle("2. round of interview", isOn: $secondRoundOfInterview)
                                if secondRoundOfInterview {
                                    DatePicker(
                                        selection: $dateOfSecondRoundOfInterview,
                                        in: startDate...endDate,
                                        displayedComponents: .date) {
                                            Text(dateOfInterview)
                                        }
                                }

                                Toggle("3. round of interview", isOn: $thirdRoundOfInterview)
                                if thirdRoundOfInterview {
                                    DatePicker(
                                        selection: $dateOfThirdRoundOfInterview,
                                        in: startDate...endDate,
                                        displayedComponents: .date) {
                                            Text(dateOfInterview)
                                        }
                                }
                            }
                        }
                    }
                }

                CustomTextEditor(with: $notes, header: "Notes")
                CustomTextEditor(with: $fullTextOffer, header: "Full text offer")
            }
            .formStyle(.grouped)
            .navigationTitle(jobOffer == nil ? "Add offer" : "Edit offer")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(jobOffer == nil ? "Save" : "Update") {
                        if jobOffer == nil {
                            addJobOffer()
                        } else {
                            // update current offer updateJobOffer()
                            updateJobOffer()
                        }
                    }
                }
            }
            // fetch exist data from jobOffer to form for edit and update
            .onAppear {
                if jobOffer != nil {
                    self.companyName = jobOffer?.viewCompanyName ?? ""
                    self.jobTitle = jobOffer?.jobTitle ?? ""
                    self.offerUrl = jobOffer?.offerUrl ?? ""
                    self.salary = jobOffer?.salary ?? ""
                    self.notes = jobOffer?.notes ?? ""
                    self.dateOfSentCv = jobOffer?.dateOfSentCv ?? Date()
                    self.response = jobOffer?.response ?? false
                    self.dateOfResponse = jobOffer?.dateOfResponse ?? Date()
                    self.firstRoundOfInterview = jobOffer?.firstRoundOfInterview ?? false
                    self.dateOfFirstRoundOfInterview = jobOffer?.dateOfFirstRoundOfInterview ?? Date()
                    self.secondRoundOfInterview = jobOffer?.secondRoundOfInterview ?? false
                    self.dateOfSecondRoundOfInterview = jobOffer?.dateOfSecondRoundOfInterview ?? Date()
                    self.thirdRoundOfInterview = jobOffer?.thirdRoundOfInterview ?? false
                    self.dateOfThirdRoundOfInterview = jobOffer?.dateOfThirdRoundOfInterview ?? Date()
                    self.fullTextOffer = jobOffer?.fullTextOffer ?? ""
                    self.status = jobOffer?.viewStatus ?? .noResponse
                    self.jobLocation = jobOffer?.jobLocation ?? ""
                    self.jobLevel = jobOffer?.viewJobLevel ?? .none

                }
            }
        }
    }

    private func addJobOffer() {
        withAnimation {
            let newJobOffer = JobOfferEntity(context: viewContext)
            newJobOffer.companyName = companyName
            newJobOffer.jobTitle = jobTitle
            newJobOffer.offerUrl = offerUrl
            newJobOffer.salary = salary
            newJobOffer.notes = notes
            newJobOffer.dateOfSentCv = dateOfSentCv
            newJobOffer.response = response
            newJobOffer.dateOfResponse = dateOfResponse
            newJobOffer.firstRoundOfInterview = firstRoundOfInterview
            newJobOffer.dateOfFirstRoundOfInterview = dateOfFirstRoundOfInterview
            newJobOffer.secondRoundOfInterview = secondRoundOfInterview
            newJobOffer.dateOfSecondRoundOfInterview = dateOfSecondRoundOfInterview
            newJobOffer.thirdRoundOfInterview = thirdRoundOfInterview
            newJobOffer.dateOfThirdRoundOfInterview = dateOfThirdRoundOfInterview
            newJobOffer.fullTextOffer = fullTextOffer
            newJobOffer.status = status.rawValue
            newJobOffer.jobLocation = jobLocation
            newJobOffer.jobLevel = jobLevel.rawValue

            persistenceController.saveContext()
            dismiss()
        }
    }

    private func updateJobOffer() {
        if let jobOffer = jobOffer {
            withAnimation {
                jobOffer.companyName = companyName
                jobOffer.jobTitle = jobTitle
                jobOffer.offerUrl = offerUrl
                jobOffer.salary = salary
                jobOffer.notes = notes
                jobOffer.dateOfSentCv = dateOfSentCv
                jobOffer.response = response
                jobOffer.dateOfResponse = dateOfResponse
                jobOffer.firstRoundOfInterview = firstRoundOfInterview
                jobOffer.dateOfFirstRoundOfInterview = dateOfFirstRoundOfInterview
                jobOffer.secondRoundOfInterview = secondRoundOfInterview
                jobOffer.dateOfSecondRoundOfInterview = dateOfSecondRoundOfInterview
                jobOffer.thirdRoundOfInterview = thirdRoundOfInterview
                jobOffer.dateOfThirdRoundOfInterview = dateOfThirdRoundOfInterview
                jobOffer.fullTextOffer = fullTextOffer
                jobOffer.status = status.rawValue
                jobOffer.jobLocation = jobLocation
                jobOffer.jobLevel = jobLevel.rawValue
            }
        }
        persistenceController.saveContext()
        dismiss()
    }

    private func CustomTextEditor(with offerText: Binding<String>, header: LocalizedStringResource) -> some View {
        Section {
            TextField("", text: offerText, axis: .vertical)
                .textFieldStyle(.plain)
                .frame(minHeight: 100, alignment: .topLeading)
        } header: {
            Text(header)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    AddUpdateOfferView(jobOffer: nil)
        .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
}
