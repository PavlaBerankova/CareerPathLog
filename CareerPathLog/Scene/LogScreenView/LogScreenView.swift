import SwiftUI

struct LogScreenView: View {
    // MARK: PROPERTIES
    @State private var username = String()
    @State private var password = String()
    @State private var testUsername = "Bershee"
    @State private var testPassword = "heslo"

    @State private var path = NavigationPath()
    @State private var showingLoginScreen = true
    @State private var wrongPassword = false
    @State private var wrongUsername = false
    let textColor = Color("Fourth")

    
    // MARK: - BODY
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.theme.mainColor
                Circle()
                    .scale(1.7)
                    .foregroundColor(Color.white.opacity(0.2))
                Circle()
                    .scale(1.35)
                    .foregroundColor(Color.white)

                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername ? 2 : 0))
                    SecureField("Password", text: $password)
                        .padding()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword ? 2 : 0))
                    Button {
                        if username == testUsername {
                            wrongUsername = false
                            if password == testPassword {
                                wrongPassword = false
                                path.append("Correct")
                            } else {
                                wrongPassword = true
                            }
                        } else {
                            wrongUsername = true
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(Color.theme.blueText)
                            .overlay {
                                Text("Submit")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                    }
                }
                .padding(.horizontal, 30)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .navigationDestination(for: String.self) { view in
                if view == "Correct" {
                    OfferListView()
                }
            }
        }
    }
       

//    func authenticateUser(username: String, password: String) {
//        if username == testUsername {
//            usernameCorrect.toggle()
//            if password == testPassword {
//                passWordCorrect = true
//                showingLoginScreen = false
//            } else {
//                wrongPassword = false
//            }
//        } else {
//            wrongUsername = false
//        }
//    }
}

// MARK: - PREVIEW
#Preview {
    LogScreenView()
}
