//
//  FavoritesManager.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favoriteHeroes"
    
    private init() {}
    
    func getFavorites() -> [Hero] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else { return [] }
        let heroes = try? JSONDecoder().decode([Hero].self, from: data)
        return heroes ?? []
    }
    
    func addFavorite(hero: Hero) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == hero.id }) {
            favorites.append(hero)
            if let data = try? JSONEncoder().encode(favorites) {
                UserDefaults.standard.set(data, forKey: favoritesKey)
            }
        }
    }
    
    func removeFavorite(hero: Hero) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == hero.id }
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
