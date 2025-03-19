//
//  FavoritesView.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    
    var body: some View {
        VStack {
            if viewModel.favorites.isEmpty {
                Text("No favorite heroes yet.")
                    .padding()
            } else {
                List {
                    ForEach(viewModel.favorites) { hero in
                        HeroRowView(hero: hero, onTap: {
                            AppRouter.shared?.pushHeroDetailView(with: hero.id)
                        })
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let hero = viewModel.favorites[index]
            viewModel.removeFavorite(hero: hero)
        }
    }
}

