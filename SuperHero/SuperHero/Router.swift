import Foundation
import SwiftUI

final class AppRouter {
    private let navigationController = UINavigationController()

    func start() -> UINavigationController {
        let view = HeroListView(router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
        return navigationController
    }

    func navigateToHeroDetail(_ hero: Hero) {
        let detailView = HeroDetailView(hero: hero)
        let detailVC = UIHostingController(rootView: detailView)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
