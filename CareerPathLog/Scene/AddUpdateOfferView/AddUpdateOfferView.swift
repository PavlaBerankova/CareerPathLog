import CoreData
import SwiftUI

struct AddUpdateOfferView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var data: PersistenceController
    let model = AddUpdateJobOfferViewModel()
    @Environment(\.dismiss) private var dismiss

    var jobOffer: JobOfferEntity?

    @State private var companyName = String()
    @State private var jobTitle = String()
    @State private var offerUrl = String()
    @State private var salary = String()
    @State private var jobLocation = String()
    @State private var jobLevel: JobLevel = .none
    @State private var typesOfEmployment: TypesOfEmployment = .none
    @State private var workingArrangements: WorkingArrangements = .none

    @State private var dateOfSentCv = Date.now
    @State private var response = false
    @State private var dateOfResponse = Date.now
    @State private var status: Status = .noResponse

    @State private var firstRoundOfInterview = false
    @State private var dateOfFirstRoundOfInterview = Date.now
    @State private var secondRoundOfInterview = false
    @State private var dateOfSecondRoundOfInterview = Date.now
    @State private var thirdRoundOfInterview = false
    @State private var dateOfThirdRoundOfInterview = Date.now

    @State private var notes = String()
    @State private var fullTextOffer = String()

    @State private var isArchived: Bool = false

    @State private var showingAlert = false
    @State private var showingAlertDelete = false
    @State private var alertMessage = LocalizedStringKey(String())

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
                if jobOffer != nil {
                    archiveButton
                    deleteButton
                }
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
            .alert(alertMessage, isPresented: $showingAlert) {
                alertOKButton
            }
            .alert("Notification", isPresented: $showingAlertDelete) {
                alertCancelButton
                alertDeleteButton
            } message: {
                Text(LocalizedStringKey("Are you sure if you want to delete this job offer?"))
            }

        }
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
    private var alertOKButton: some View {
        Button("OK", role: .none) {
            if isArchived || model.validateTextField(companyName, jobTitle).isNotEmpty {
                dismiss()
            }
        }
    }

    private var alertDeleteButton: some View {
        Button("Delete", role: .destructive) {
            guard let jobOffer else { return }
            data.delete(item: jobOffer)
            dismiss()
        }
    }

    private var alertCancelButton: some View {
        Button("Cancel", role: .cancel) { }
    }

    private func addJobOffer() {
        data.addJobOffer(
            companyName: companyName,
            jobTitle: jobTitle,
            offerUrl: offerUrl,
            salary: salary,
            notes: notes,
            dateOfSentCv: dateOfSentCv,
            response: response,
            dateOfResponse: dateOfResponse,
            firstRoundOfInterview: firstRoundOfInterview,
            dateOfFirstRoundOfInterview: dateOfFirstRoundOfInterview,
            secondRoundOfInterview: secondRoundOfInterview,
            dateOfSecondRoundOfInterview: dateOfSecondRoundOfInterview,
            thirdRoundOfInterview: thirdRoundOfInterview,
            dateOfThirdRoundOfInterview: dateOfThirdRoundOfInterview,
            fullTextOffer: fullTextOffer,
            status: status,
            jobLocation: jobLocation,
            jobLevel: jobLevel,
            typesOfEmployment:typesOfEmployment,
            workingArrangements: workingArrangements,
            isArchived: isArchived
        )
    }

    private func updateJobOffer() {
        data.updateJobOffer(
            jobOffer: jobOffer,
            newCompanyName: companyName,
            newJobTitle: jobTitle,
            newOfferUrl: offerUrl,
            newSalary: salary,
            newNotes: notes,
            newDateOfSentCv: dateOfSentCv,
            newResponse: response,
            newDateOfResponse: dateOfResponse,
            newFirstRoundOfInterview: firstRoundOfInterview,
            newDateOfFirstRoundOfInterview: dateOfFirstRoundOfInterview,
            newSecondRoundOfInterview: secondRoundOfInterview,
            newDateOfSecondRoundOfInterview: dateOfSecondRoundOfInterview,
            newThirdRoundOfInterview: thirdRoundOfInterview,
            newDateOfThirdRoundOfInterview: dateOfThirdRoundOfInterview,
            newFullTextOffer: fullTextOffer,
            newStatus: status,
            newJobLocation: jobLocation,
            newJobLevel: jobLevel,
            newTypesOfEmployment: typesOfEmployment,
            newWorkingArrangements: workingArrangements,
            isArchived: isArchived
        )
    }

    private var saveUpdateButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(jobOffer == nil ? "Save" : "Update") {
                if model.validateTextField(companyName, jobTitle).isNotEmpty {
                    if jobOffer == nil {
                        addJobOffer()
                    } else {
                        updateJobOffer()
                    }
                    dismiss()
                } else {
                    showAlert(with: model.validateTextField(companyName, jobTitle).message) {
                        showingAlert.toggle()
                    }
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
            if isArchived {
                // Remove from archive
                isArchived = false
                updateJobOffer()
                showAlert(with: LocalizedStringKey("Job Offer was remove from archive.")) {
                    showingAlert.toggle()
                }
            } else {
                // Move to archive
                isArchived = true
                updateJobOffer()
                showAlert(with: LocalizedStringKey("Job Offer was move to archive.")) {
                    showingAlert.toggle()
                }
            }
        } label: {
            HStack {
                Image(systemName: "archivebox")
                Text(isArchived == true ? LocalizedStringKey("Remove from Archive") : "Move to Archive")
            }
        }
    }

    private var deleteButton: some View {
        Button {
            showAlert(with: LocalizedStringKey("Are you sure, if you want to delete this job offer?")) {
                showingAlertDelete.toggle()
            }
        } label: {
            HStack {
                Image(systemName: "trash")
                Text(LocalizedStringKey("Delete"))
            }
            .foregroundColor(.red)
        }
    }

    private func showAlert(with message: LocalizedStringKey, action: () -> Void) {
        alertMessage = message
        action()
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
        self.isArchived = jobOffer?.isArchived ?? false
    }
}

// MARK: - PREVIEW
#Preview {
    AddUpdateOfferView(jobOffer: nil)
        .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
}
