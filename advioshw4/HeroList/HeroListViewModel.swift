//
//  HeroListViewModel.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import Foundation

class HeroListViewModel: ObservableObject {
    @Published var heroes: [Hero] = []
    @Published var filteredHeroes: [Hero] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // A simple property observer triggers filtering when the search query changes.
    var searchQuery: String = "" {
        didSet {
            filterHeroes(query: searchQuery)
        }
    }
    
    init() {
        Task {
            await fetchHeroes()
        }
    }
    
    func fetchHeroes() async {
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let heroes = try await HeroService.shared.fetchAllHeroes()
            await MainActor.run {
                self.heroes = heroes
                self.filteredHeroes = heroes
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func filterHeroes(query: String) {
        if query.isEmpty {
            filteredHeroes = heroes
        } else {
            filteredHeroes = heroes.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
}

