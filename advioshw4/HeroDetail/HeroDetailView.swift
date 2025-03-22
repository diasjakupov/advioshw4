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
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let hero = viewModel.hero {
                        VStack(spacing: 0) {
                            ZStack {
                                if let imageUrl = hero.heroImageUrl {
                                    AsyncImage(url: imageUrl) { phase in
                                        switch phase {
                                        case .empty:
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .overlay(ProgressView())
                                                .aspectRatio(1.0, contentMode: .fit)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 350)
                                                .clipped()
                                        case .failure:
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .overlay(
                                                    Image(systemName: "person.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 100, height: 100)
                                                        .foregroundColor(.gray)
                                                )
                                                .frame(height: 350)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.red)
                                    .scaleEffect(animateHeart ? 1.5 : 0.8)
                                    .opacity(animateHeart ? 1.0 : 0.0)
                                    .animation(.easeInOut(duration: 0.5), value: animateHeart)
                            }
                            
                            Spacer()
                                .frame(height: 30)
                            
                            Text(hero.name)
                                .font(.system(size: 38, weight: .bold, design: .rounded))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                        }
                        
                        FavoriteButton(isFavorite: viewModel.isFavorite) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                viewModel.toggleFavorite()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        VStack(spacing: 16) {
                            SectionView(sectionTitle: "Biography", systemIcon: "person.text.rectangle") {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let fullName = hero.biography.fullName, !fullName.isEmpty {
                                        InfoRow(label: "Full Name", value: fullName)
                                    }
                                    if let alterEgos = hero.biography.alterEgos, !alterEgos.isEmpty {
                                        InfoRow(label: "Alter Egos", value: alterEgos)
                                    }
                                    if let aliases = hero.biography.aliases, !aliases.isEmpty {
                                        InfoRow(label: "Aliases", value: aliases.joined(separator: ", "))
                                    }
                                    if let placeOfBirth = hero.biography.placeOfBirth, !placeOfBirth.isEmpty {
                                        InfoRow(label: "Place of Birth", value: placeOfBirth)
                                    }
                                    if let firstAppearance = hero.biography.firstAppearance, !firstAppearance.isEmpty {
                                        InfoRow(label: "First Appearance", value: firstAppearance)
                                    }
                                    if let publisher = hero.biography.publisher, !publisher.isEmpty {
                                        InfoRow(label: "Publisher", value: publisher)
                                    }
                                    if let alignment = hero.biography.alignment, !alignment.isEmpty {
                                        InfoRow(label: "Alignment", value: alignment.capitalized)
                                    }
                                }
                            }
                            
                            SectionView(sectionTitle: "Power Stats", systemIcon: "bolt.fill") {
                                VStack(alignment: .leading, spacing: 10) {
                                    if let intelligence = hero.powerstats.intelligence {
                                        StatBar(label: "Intelligence", value: intelligence.description, color: .blue)
                                    }
                                    if let strength = hero.powerstats.strength {
                                        StatBar(label: "Strength", value: strength.description, color: .red)
                                    }
                                    if let speed = hero.powerstats.speed {
                                        StatBar(label: "Speed", value: speed.description, color: .green)
                                    }
                                    if let durability = hero.powerstats.durability {
                                        StatBar(label: "Durability", value: durability.description, color: .orange)
                                    }
                                    if let power = hero.powerstats.power {
                                        StatBar(label: "Power", value: power.description, color: .purple)
                                    }
                                    if let combat = hero.powerstats.combat {
                                        StatBar(label: "Combat", value: combat.description, color: .gray)
                                    }
                                }
                            }
                            
                            SectionView(sectionTitle: "Appearance", systemIcon: "person.fill") {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let gender = hero.appearance?.gender, !gender.isEmpty {
                                        InfoRow(label: "Gender", value: gender)
                                    }
                                    if let race = hero.appearance?.race, !race.isEmpty {
                                        InfoRow(label: "Race", value: race)
                                    }
                                    if let height = hero.appearance?.height?.first, !height.isEmpty {
                                        InfoRow(label: "Height", value: height)
                                    }
                                    if let weight = hero.appearance?.weight?.first, !weight.isEmpty {
                                        InfoRow(label: "Weight", value: weight)
                                    }
                                    if let eyeColor = hero.appearance?.eyeColor, !eyeColor.isEmpty {
                                        InfoRow(label: "Eye Color", value: eyeColor)
                                    }
                                    if let hairColor = hero.appearance?.hairColor, !hairColor.isEmpty {
                                        InfoRow(label: "Hair Color", value: hairColor)
                                    }
                                }
                            }
                            
                            SectionView(sectionTitle: "Work", systemIcon: "briefcase.fill") {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let occupation = hero.work?.occupation, !occupation.isEmpty {
                                        InfoRow(label: "Occupation", value: occupation)
                                    }
                                    if let base = hero.work?.base, !base.isEmpty {
                                        InfoRow(label: "Base", value: base)
                                    }
                                }
                            }
                            
                            SectionView(sectionTitle: "Connections", systemIcon: "person.2.fill") {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let groupAffiliation = hero.connections?.groupAffiliation, !groupAffiliation.isEmpty {
                                        InfoRow(label: "Group Affiliation", value: groupAffiliation)
                                    }
                                    if let relatives = hero.connections?.relatives, !relatives.isEmpty {
                                        InfoRow(label: "Relatives", value: relatives)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    } else if viewModel.isLoading {
                        LoadingView()
                            .frame(maxWidth: .infinity, minHeight: 300)
                    } else if let error = viewModel.errorMessage {
                        ErrorView(message: error)
                            .frame(maxWidth: .infinity, minHeight: 300)
                    }
                }
                .padding(.bottom, 32)
                .onChange(of: viewModel.isFavorite) { _, newValue in
                    if newValue {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            animateHeart = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                animateHeart = false
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct FavoriteButton: View {
    let isFavorite: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.headline)
                Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isFavorite ? Color.red : Color.blue)
                    .shadow(color: (isFavorite ? Color.red : Color.blue).opacity(0.4), radius: 8, x: 0, y: 4)
            )
            .foregroundColor(.white)
        }
    }
}






