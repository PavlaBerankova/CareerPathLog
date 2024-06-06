import CoreData
import SwiftUI

struct AddUpdateOfferView: View {
    // MARK: - PROPERTIES
    var jobOffer: JobOfferEntity?

    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var companyName = String()
    @State private var jobTitle = String()
    @State private var offerUrl = String()
    @State private var salary = String()
    @State private var jobLocation = String()
    @State private var jobLevel: JobLevel = .none
    @State private var typesOfEmployment: TypesOfEmployment = .none
    @State private var workingArrangements: WorkingArrangements = .none

    @State private var dateOfSentCv = Date()
    @State private var response = false
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
                infoSection
                dateAndResponseSection
                if status == .interview {
                    interviewSection
                }
                notesAndFulltextOfferSection
                archiveButton
                deleteButton
            }
            .formStyle(.grouped)
            .navigationTitle(jobOffer == nil ? "Add offer" : "Edit offer")
            .toolbar {
                saveUpdateButton
                backButton
            }
            .onAppear {
                fetchJobOffer()
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
            newJobOffer.typesOfEmployment = typesOfEmployment.rawValue
            newJobOffer.workingArrangements = workingArrangements.rawValue

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
                jobOffer.typesOfEmployment = typesOfEmployment.rawValue
                jobOffer.workingArrangements = workingArrangements.rawValue
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

// MARK: - EXTENSION
extension AddUpdateOfferView {
    private var saveUpdateButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(jobOffer == nil ? "Save" : "Update") {
                if jobOffer == nil {
                    addJobOffer()
                } else {
                    updateJobOffer()
                }
            }
        }
    }

    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        }
    }

    private var infoSection: some View {
        Section {
            TextField("Company name", text: $companyName)
            TextField("Job title", text: $jobTitle)
            TextField("URL offer", text: $offerUrl)
            TextField("Salary", text: $salary)
            TextField("Job location", text: $jobLocation)

            Picker("Types of Employment", selection: $typesOfEmployment) {
                Text("Choose type").tag(nil as TypesOfEmployment?)
                Divider()

                Text("Part-time").tag(TypesOfEmployment.partTime)
                Text("Full-time").tag(TypesOfEmployment.fullTime)
            }
            .pickerStyle(.menu)

            Picker("Working arrangements", selection: $workingArrangements) {
                Text("Choose Type").tag(nil as WorkingArrangements?)
                Divider()

                Text("Remote").tag(WorkingArrangements.remote)
                Text("On-site").tag(WorkingArrangements.onSite)
                Text("Hybrid").tag(WorkingArrangements.hybrid)
            }

            Picker("Job level", selection: $jobLevel) {
                Text("junior").tag(JobLevel.junior)
                Text("medior").tag(JobLevel.medior)
                Text("senior").tag(JobLevel.senior)
            }
            .pickerStyle(.segmented)
        } header: {
            Text("Info")
        }
    }

    private var dateAndResponseSection: some View {
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
            }
        }
    }

    private var interviewSection: some View {
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
        } header: {
            Text("Interviews")
        }
    }

    private var notesAndFulltextOfferSection: some View {
        Group {
            CustomTextEditor(with: $notes, header: "Notes")
            CustomTextEditor(with: $fullTextOffer, header: "Full text offer")
        }
    }

    private var archiveButton: some View {
        Button {
            if status != .archive {
                status = .archive
                updateJobOffer()
            } else {
                status = .noResponse
                updateJobOffer()
            }
            // TODO: - show alert about move to archive
        } label: {
            HStack {
                Image(systemName: "archivebox")
                Text(LocalizedStringKey(status == .archive ? "Remove from Archive" : "Move to Archive"))
            }
        }
    }

    private var deleteButton: some View {
        Button {
            if let jobOffer = jobOffer {
                persistenceController.delete(item: jobOffer)
                updateJobOffer()
            }
        } label: {
            HStack {
                Image(systemName: "trash")
                Text(LocalizedStringKey("Delete"))
            }
        }

    }

    private func fetchJobOffer() {
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
        self.typesOfEmployment = jobOffer?.viewTypesOfEmployment ?? .none
        self.workingArrangements = jobOffer?.viewWorkingArrangements ?? .none

    }
}

// MARK: - PREVIEW
#Preview {
    AddUpdateOfferView(jobOffer: nil)
        .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
}
