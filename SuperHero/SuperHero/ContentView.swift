import SwiftUI

struct HeroListView: View {
    @StateObject var viewModel = HeroListViewModel()
    var router: AppRouter

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search heroes...", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.filteredHeroes) { hero in
                        Button(action: {
                            router.navigateToHeroDetail(hero)
                        }) {
                            HeroCardView(hero: hero)
                        }
                    }
                }
            }
            .navigationTitle("Heroes")
            .onAppear { viewModel.fetchHeroes() }
        }
    }
}

struct HeroCardView: View {
    let hero: Hero

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: hero.images.sm)) { image in
                image.resizable().frame(width: 60, height: 60).clipShape(Circle())
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                Text(hero.name).font(.headline)
                if let power = hero.powerstats.power {
                    Text("Power: \(power)")
                }
            }
        }
    }
}

struct HeroDetailView: View {
    let hero: Hero

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: hero.images.lg)) { image in
                    image.resizable().aspectRatio(contentMode: .fit).cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                Text(hero.name).font(.largeTitle).bold()
                Text("Full Name: \(hero.biography.fullName ?? "N/A")")
                Text("Place of Birth: \(hero.biography.placeOfBirth ?? "Unknown")")
                Text("First Appearance: \(hero.biography.firstAppearance ?? "N/A")")

                VStack(alignment: .leading, spacing: 8) {
                    Text("Power Stats:").font(.headline)
                    Text("Intelligence: \(hero.powerstats.intelligence ?? 0)")
                    Text("Strength: \(hero.powerstats.strength ?? 0)")
                    Text("Speed: \(hero.powerstats.speed ?? 0)")
                    Text("Durability: \(hero.powerstats.durability ?? 0)")
                    Text("Power: \(hero.powerstats.power ?? 0)")
                    Text("Combat: \(hero.powerstats.combat ?? 0)")
                }
            }
            .padding()
        }
        .navigationTitle(hero.name)
    }
}
