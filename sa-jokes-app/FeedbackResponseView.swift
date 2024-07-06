import SwiftUI

struct FeedbackResponseView: View {
    
    var isPositive: Bool
    
    var body: some View {
        VStack {
            Image(isPositive ? "happy" : "sad")
                .resizable()
                .scaledToFit()
            Text(isPositive ? "Thanks! Have a cookie 🍪!" : "Why are you so mean?? I will bite you.")
                .padding()
        }
    }
}

#Preview {
    FeedbackResponseView(isPositive: true)
}

#Preview {
   FeedbackResponseView(isPositive: false)
}
