import Foundation
import SwiftUI

final class HeroService {
    func fetchAllHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        guard let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }

            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                completion(.success(heroes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
