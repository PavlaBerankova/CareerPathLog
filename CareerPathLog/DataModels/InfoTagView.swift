import SwiftUI

struct InfoTagView: View {
  let title: String

  var body: some View {
    Text(title)
      .padding(.vertical, 4)
      .padding(.horizontal, 8)
      .frame(width: 70, height: 20)
      .background(
        Color.gray.opacity(0.08)

      )
      .foregroundColor(.black)
      .font(.caption2)
      .cornerRadius(8)
  }
}

#Preview {
  InfoTagView(title: "Full-time")
}
