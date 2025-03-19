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



