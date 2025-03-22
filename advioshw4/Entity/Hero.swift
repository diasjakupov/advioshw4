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
    let appearance: Appearance?
    let work: Work?
    let connections: Connections?
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

struct Appearance: Codable {
    let gender: String?
    let race: String?
    let height: [String]?
    let weight: [String]?
    let eyeColor: String?
    let hairColor: String?
}

struct Work: Codable {
    let occupation: String?
    let base: String?
}

struct Connections: Codable {
    let groupAffiliation: String?
    let relatives: String?
}
