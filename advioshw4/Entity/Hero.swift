//
//  Hero.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import Foundation

struct Hero: Codable, Identifiable {
    let id: Int
    let name: String
    let images: HeroImage
    var heroImageUrl: URL? {
        URL(string: images.sm)
    }
    let powerstats: PowerStats
    let biography: Biography
}

struct HeroImage: Codable {
    let sm: String
    let md: String
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
    let alterEgos: String?
    let aliases: [String]?
    let placeOfBirth: String?
    let firstAppearance: String?
    let publisher: String?
    let alignment: String?
}
