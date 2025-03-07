//
//  ContentView.swift
//  Hero
//
//  Created by Bakustar Zhumadil on 07.03.2025.
//

import SwiftUI
import Foundation

struct Hero: Codable, Identifiable {
    let id: Int
    let name: String
    let images: ImageURLs
    let powerstats: PowerStats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
}

struct PowerStats: Codable {
    let intelligence, strength, speed, durability, power, combat: Int
}

struct Biography: Codable {
    let fullName: String
    let publisher: String?
}

struct Appearance: Codable {
    let gender, race: String?
    let height, weight: [String]
}

struct Work: Codable {
    let occupation: String
    let base: String
}

struct Connections: Codable {
    let groupAffiliation: String
    let relatives: String
}

struct ImageURLs: Codable {
    let lg: String
}

class HeroViewModel: ObservableObject {
    @Published var hero: Hero?

    func fetchHero() {
        guard let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    if let heroes = try? JSONDecoder().decode([Hero].self, from: data) {
                        self.hero = heroes.randomElement()
                    }
                }
            }
        }.resume()
    }
}

struct HeroRandomizerView: View {
    @StateObject private var viewModel = HeroViewModel()

    var body: some View {
        VStack {
            if let hero = viewModel.hero {
                Text(hero.name).font(.title).bold()
                
                AsyncImage(url: URL(string: hero.images.lg)) { image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(height: 300)
                Text(hero.name).font(.largeTitle).bold()
                                    Text(hero.biography.fullName)
                                        .foregroundColor(.gray)

                Text("Name: \(hero.biography.fullName)")
                Text("Race: \(hero.appearance.race ?? "Неизвестно")")
                Text("Height: \(hero.appearance.height[1])")
                Text("Weight: \(hero.appearance.weight[1])")
                Text("Strength: \(hero.powerstats.strength)")
                Text("Speed: \(hero.powerstats.speed)")
                Text("Intelligence: \(hero.powerstats.intelligence)")
            } else {
                Text("Нажмите кнопку для загрузки героя2")
            }

            Button("Random Hero") {
                viewModel.fetchHero()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            viewModel.fetchHero()
        }
    }
}

