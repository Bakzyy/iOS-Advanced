struct Hero: Identifiable, Codable {
    let id: Int
    let name: String
    let images: HeroImages
    let powerstats: PowerStats
    let biography: Biography
}

struct HeroImages: Codable {
    let sm: String
    let md: String
    let lg: String
}

struct PowerStats: Codable {
    let intelligence: Int?
    let strength: Int?
    let speed: Int?
    let durability: Int?
    let power: Int?
    let combat: Int?
}

struct Biography: Codable {
    let fullName: String?
    let placeOfBirth: String?
    let firstAppearance: String?
}
