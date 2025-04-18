import Foundation
import SwiftUI

struct WeatherComponentView<T, Content: View>: View {
    let title: String
    let state: LoadingState<T>
    let content: (T) -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline)
            switch state {
            case .idle:
                Text("Idle")
            case .loading:
                ProgressView("Loading...")
            case .failure(let error):
                Text("Error: \(error.localizedDescription)").foregroundColor(.red)
            case .success(let value):
                content(value)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

