//
//  HeroDetailviewModel.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import Foundation

class HeroDetailViewModel: ObservableObject {
    @Published var hero: Hero?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isFavorite: Bool = false

    let heroId: Int

    init(heroId: Int) {
        self.heroId = heroId
        Task {
            await self.fetchHeroDetails(id: heroId)
        }
    }
    
    func fetchHeroDetails(id: Int) async {
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let fetchedHero = try await HeroService.shared.fetchHeroDetails(id: id)
            await MainActor.run {
                self.hero = fetchedHero
                self.isFavorite = FavoritesManager.shared
                    .getFavorites()
                    .contains(where: { $0.id == fetchedHero.id })
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }

    
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




