import SwiftUI

struct RootViewControllerRepresentable: UIViewControllerRepresentable {
    let router = AppRouter()

    func makeUIViewController(context: Context) -> UINavigationController {
        return router.start()
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
