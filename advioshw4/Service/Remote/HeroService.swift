//
//  HeroService.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class HeroService {
    static let shared = HeroService()
    
    private init() {}
    
    private let baseURL = "https://akabab.github.io/superhero-api/api"
    
    // Async method for fetching all heroes
    func fetchAllHeroes() async throws -> [Hero] {
        guard let url = URL(string: "\(baseURL)/all.json") else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let heroes = try JSONDecoder().decode([Hero].self, from: data)
        return heroes.filter { hero in
            hero.heroImageUrl != nil
        }
    }
    
    // Async method for fetching hero details by ID
    func fetchHeroDetails(id: Int) async throws -> Hero {
        guard let url = URL(string: "\(baseURL)/id/\(id).json") else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let hero = try JSONDecoder().decode(Hero.self, from: data)
        return hero
    }
}

