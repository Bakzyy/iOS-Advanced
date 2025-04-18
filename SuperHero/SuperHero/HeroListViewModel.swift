import Foundation
import SwiftUI

final class HeroListViewModel: ObservableObject {
    @Published var heroes: [Hero] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let service = HeroService()

    var filteredHeroes: [Hero] {
        if searchText.isEmpty {
            return heroes
        } else {
            return heroes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func fetchHeroes() {
        isLoading = true
        service.fetchAllHeroes { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let heroes):
                    self?.heroes = heroes
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
