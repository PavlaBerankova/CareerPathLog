import CoreData
import SwiftUI

struct AddUpdateOfferView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var data: PersistenceController
    @Environment(\.dismiss) private var dismiss

    @StateObject var model = AddUpdateOfferViewModel()

    var jobOffer: JobOfferEntity?

    let startDate = Date.distantPast
    let endDate = Date.distantFuture
    let dateOfInterview: LocalizedStringKey = "    Date of interview"

    // MARK: - BODY
    var body: some View {
        NavigationStack {
            Form {
                infoSection
                dateAndResponseSection
                if model.content.status == .interview {
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
            .alert(model.alertMessage, isPresented: $model.showingAlert) {
                alertOKButton
            }
            .alert("Notification", isPresented: $model.showingAlertDelete) {
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
            if model.content.isArchived ||
                model.companyAndJobTitleTextFieldIsNotEmpty() == true {
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
        data.addNewJobOffer(jobOffer: model.content)
    }

    private func updateJobOffer() {
        data.updateJobOffer(jobOffer: jobOffer, updatedContent: model.content)
    }

    private var saveUpdateButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(jobOffer == nil ? "Save" : "Update") {
                if model.companyAndJobTitleTextFieldIsNotEmpty() {
                    if jobOffer == nil {
                        addJobOffer()
                    } else {
                        updateJobOffer()
                    }
                    dismiss()
                } else {
                    showAlert(message: model.alertMessage) {
                        model.showingAlert.toggle()
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
            TextField("Company name", text: $model.content.companyName)
            TextField("Job title", text: $model.content.jobTitle)
            TextField("URL offer", text: $model.content.offerUrl)
            TextField("Salary", text: $model.content.salary)
            TextField("Job location", text: $model.content.jobLocation)

            Picker("Types of Employment", selection: $model.content.typesOfEmployment) {
                Text("Choose type").tag(nil as TypesOfEmployment?)
                Divider()

                Text("Part-time").tag(TypesOfEmployment.partTime)
                Text("Full-time").tag(TypesOfEmployment.fullTime)
            }
            .pickerStyle(.menu)

            Picker("Working arrangements", selection: $model.content.workingArrangements) {
                Text("Choose Type").tag(nil as WorkingArrangements?)
                Divider()

                Text("Remote").tag(WorkingArrangements.remote)
                Text("On-site").tag(WorkingArrangements.onSite)
                Text("Hybrid").tag(WorkingArrangements.hybrid)
            }

            Picker("Job level", selection: $model.content.jobLevel) {
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
                selection: $model.content.dateOfSentCv,
                in: startDate...endDate,
                displayedComponents: .date) {
                    Text("Date of submitted CV")
                }
            Toggle("Response", isOn: $model.content.response)
            if model.content.response {
                DatePicker(
                    selection: $model.content.dateOfResponse,
                    in: startDate...endDate,
                    displayedComponents: .date) {
                        Text("Date of response")
                    }

                Section {
                    Picker("Type of response", selection: $model.content.status) {
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
            Toggle("1. round of interview", isOn: $model.content.firstRoundOfInterview)
            if model.content.firstRoundOfInterview {
                DatePicker(
                    selection: $model.content.dateOfFirstRoundOfInterview,
                    in: startDate...endDate,
                    displayedComponents: .date) {
                        Text(dateOfInterview)
                    }
            }

            Toggle("2. round of interview", isOn: $model.content.secondRoundOfInterview)
            if model.content.secondRoundOfInterview {
                DatePicker(
                    selection: $model.content.dateOfSecondRoundOfInterview,
                    in: startDate...endDate,
                    displayedComponents: .date) {
                        Text(dateOfInterview)
                    }
            }

            Toggle("3. round of interview", isOn: $model.content.thirdRoundOfInterview)
            if model.content.thirdRoundOfInterview {
                DatePicker(
                    selection: $model.content.dateOfThirdRoundOfInterview,
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
            CustomTextEditor(with: $model.content.notes, header: "Notes")
            CustomTextEditor(with: $model.content.fullTextOffer, header: "Full text offer")
        }
    }

    private var archiveButton: some View {
        Button {
            if model.content.isArchived {
                // Remove from archive
                model.content.isArchived = false
                updateJobOffer()
                model.alertMessage = LocalizedStringKey("Job Offer was remove from archive.")
                model.showingAlert.toggle()
            } else {
                // Move to archive
                model.content.isArchived = true
                updateJobOffer()
                model.alertMessage = LocalizedStringKey("Job Offer was move to archive.")
                model.showingAlert.toggle()
            }
        } label: {
            HStack {
                Image(systemName: "archivebox")
                Text(model.content.isArchived == true ? LocalizedStringKey("Remove from Archive") : "Move to Archive")
            }
        }
    }

    private var deleteButton: some View {
        Button {
            showAlert(message: LocalizedStringKey("Are you sure, if you want to delete this job offer?")) {
                model.showingAlertDelete.toggle()
            }
        } label: {
            HStack {
                Image(systemName: "trash")
                Text(LocalizedStringKey("Delete"))
            }
            .foregroundColor(.red)
        }
    }

    private func showAlert(message: LocalizedStringKey, action: () -> Void) {
        model.alertMessage = message
        action()
    }

    private func fetchJobOffer() {
        if let jobOffer = jobOffer {
               model.content = JobOfferEntityConverter.convert(model: jobOffer)
           }
    }
}

// MARK: - PREVIEW
#Preview {
    AddUpdateOfferView(jobOffer: nil)
        .environment(\.managedObjectContext, PersistenceController(forPreview: true).container.viewContext)
}

