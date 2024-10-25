import SwiftUI

struct CustomButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Weather Forecast")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.systemPrimaryColor)
                .cornerRadius(25)
               
        }
        .padding(.horizontal, 20)
    }
}
