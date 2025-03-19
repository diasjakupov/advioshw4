//
//  HeroListView.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import SwiftUI

struct HeroListView: View {
    @ObservedObject var viewModel: HeroListViewModel
    
    var body: some View {
        VStack {
            TextField("Search heroes", text: Binding(
                get: { viewModel.searchQuery },
                set: { viewModel.searchQuery = $0 }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            if viewModel.isLoading {
                ProgressView("Loading heroes...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
            } else {
                List {
                    ForEach(viewModel.filteredHeroes) { hero in
                        HeroRowView(hero: hero, onTap: {
                            AppRouter.shared?.pushHeroDetailView(with: hero)
                        })
                    }
                }
            }
        }
    }
}



struct HeroRowView: View {
    let hero: Hero
    var onTap: (() -> Void)?
    
    var body: some View {
        HStack {
            if let imageUrl = hero.heroImageUrl {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "person.fill")
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            VStack(alignment: .leading) {
                Text(hero.name)
                    .font(.headline)
                if let intelligence = hero.powerstats.intelligence {
                    Text("Intelligence: \(intelligence)")
                        .font(.subheadline)
                }
            }
        }
        .contentShape(Rectangle()) 
        .onTapGesture {
            onTap?()
        }
    }
}
