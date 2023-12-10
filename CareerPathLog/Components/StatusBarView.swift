//import SwiftUI
//
//struct StatusBarView: View {
//    let totalSendCv: Int
//    let noResponseCount: Int
//    let interviewCount: Int
//    let acceptedCount: Int
//    let rejectedCount: Int
//    var action: () -> Void
//
//    var body: some View {
//        HStack {
//            StatusButtonView(symbol: Image.status.sending, count: totalSendCv, action: action)
//            StatusButtonView(symbol: Image.status.noResponse, count: noResponseCount, action: { })
//            StatusButtonView(symbol: Image.status.interview, count: interviewCount, action: { })
//            StatusButtonView(symbol: Image.status.accepted, count: acceptedCount, action: { })
//            StatusButtonView(symbol: Image.status.rejected, count: rejectedCount, action: { })
//        }
////        HStack(spacing: 10) {
////            VStack(spacing: 8) {
////                Image.status.sending
////                Text("\(countSendCV)")
////                    .font(.headline)
////            }
////            .padding()
////            .padding(.horizontal, 5)
////            .background(Color.gray.opacity(0.1))
////            .cornerRadius(10)
////
////            VStack(spacing: 8) {
////                Image.status.noResponse
////                Text("\(countNoResponse)")
////                    .font(.headline)
////            }
////            .padding()
////            .padding(.horizontal, 5)
////            .background(Color.gray.opacity(0.1))
////            .cornerRadius(10)
////
////            VStack(spacing: 8) {
////                Image.status.interview
////                Text("\(countInterview)")
////                    .font(.headline)
////            }
////            .padding()
////            .padding(.horizontal, 5)
////            .background(Color.gray.opacity(0.1))
////            .cornerRadius(10)
////
////            VStack(spacing: 8) {
////                Image.status.rejected
////                Text("\(countRejected)")
////                    .font(.headline)
////            }
////            .padding()
////            .padding(.horizontal, 5)
////            .background(Color.gray.opacity(0.1))
////            .cornerRadius(10)
////
////            VStack(spacing: 8) {
////                Image.status.accepted
////                Text("\(countAccepted)")
////                    .font(.headline)
////            }
////            .padding()
////            .padding(.horizontal, 5)
////            .background(Color.gray.opacity(0.1))
////            .cornerRadius(10)
////        }
//    }
//}
//
//#Preview {
//    StatusBarView(totalSendCv: 0, noResponseCount: 0, interviewCount: 1, acceptedCount: 0, rejectedCount: 3, action: { })
//}
