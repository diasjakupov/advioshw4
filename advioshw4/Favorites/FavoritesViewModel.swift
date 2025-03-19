//
//  FavoritesViewModel.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Hero] = []
    
    init() {
        fetchFavorites()
    }
    
    // Fetches favorite heroes from the FavoritesManager.
    func fetchFavorites() {
        favorites = FavoritesManager.shared.getFavorites()
    }
    
    // Removes a hero from favorites and refreshes the list.
    func removeFavorite(hero: Hero) {
        FavoritesManager.shared.removeFavorite(hero: hero)
        fetchFavorites()
    }
}
