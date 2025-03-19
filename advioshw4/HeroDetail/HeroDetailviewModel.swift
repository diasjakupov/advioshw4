//
//  HeroDetailviewModel.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import Foundation

class HeroDetailViewModel: ObservableObject {
    
    @Published var hero: Hero? {
        didSet {
            // Check and update favorite status as soon as the hero is set.
            if let hero = hero {
                self.isFavorite = FavoritesManager.shared
                    .getFavorites()
                    .contains(where: { $0.id == hero.id })
            }
        }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isFavorite: Bool = false
    
    
    // Toggle the hero's favorite status via FavoritesManager.
    func toggleFavorite() {
        guard let hero = hero else { return }
        if isFavorite {
            FavoritesManager.shared.removeFavorite(hero: hero)
            self.isFavorite = false
        } else {
            FavoritesManager.shared.addFavorite(hero: hero)
            self.isFavorite = true
        }
    }
}



