import Foundation

extension Date {
    func formattedDate() -> String {
        self.formatted(.dateTime.day().month().year())
    }
}
