//
//  HeroDetailView.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//


import SwiftUI

struct HeroDetailView: View {
    @ObservedObject var viewModel: HeroDetailViewModel
    @State private var animateHeart = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let hero = viewModel.hero {
                    Text(hero.name)
                        .font(.largeTitle)
                        .bold()
                    
                    // ZStack for the hero image and heart overlay animation.
                    ZStack {
                        if let imageUrl = hero.heroImageUrl {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                case .failure:
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        // Heart overlay that appears when the hero is added to favorites.
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)
                            .scaleEffect(animateHeart ? 1.5 : 1.0)
                            .opacity(animateHeart ? 1.0 : 0.0)
                            .animation(.easeInOut(duration: 0.3), value: animateHeart)
                    }
                    
                    // Button that toggles the favorite status.
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.toggleFavorite()
                        }
                    }) {
                        Text(viewModel.isFavorite ? "Delete from Favorites" : "Add to Favorites")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.isFavorite ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top)
                    
                    Group {
                        Text("Biography")
                            .font(.title2)
                        if let fullName = hero.biography.fullName {
                            Text("Full Name: \(fullName)")
                        }
                        if let publisher = hero.biography.publisher {
                            Text("Publisher: \(publisher)")
                        }
                    }
                    
                    Group {
                        Text("Power Stats")
                            .font(.title2)
                        if let intelligence = hero.powerstats.intelligence {
                            Text("Intelligence: \(intelligence)")
                        }
                        if let strength = hero.powerstats.strength {
                            Text("Strength: \(strength)")
                        }
                    }
                } else if viewModel.isLoading {
                    ProgressView("Loading details...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                }
            }
            .padding()
            // Listen for changes in favorite status.
            .onChange(of: viewModel.isFavorite) { _, newValue in
                if newValue {
                    // Animate the heart overlay when a hero is added to favorites.
                    withAnimation(.easeInOut(duration: 0.3)) {
                        animateHeart = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            animateHeart = false
                        }
                    }
                }
            }
        }
    }
}
