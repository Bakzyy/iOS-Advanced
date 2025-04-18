import SwiftUI

@main
struct SuperHeroApp: App {
    var body: some Scene {
        WindowGroup {
            RootViewControllerRepresentable()
                .ignoresSafeArea()
        }
    }
}
