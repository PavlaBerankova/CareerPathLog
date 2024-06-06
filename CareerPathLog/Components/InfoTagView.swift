import SwiftUI

struct InfoTagView: View {
// MARK: - PROPERTIES
  let title: String
  let textColor: Color
    let backgroundColor: Color

// MARK: - BODY
  var body: some View {
          Text(title)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .frame(height: 20)
            .background(
              backgroundColor
            )
            .foregroundColor(textColor)
            .font(.caption2)
            .cornerRadius(8)
  }
}

// MARK: - PREVIEW
#Preview {
    InfoTagView(title: "Full-time/par-time", textColor: .black, backgroundColor: Color.gray.opacity(0.08))
}
