//
//  SectionView.swift
//  advioshw4
//
//  Created by Dias Jakupov on 22.03.2025.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let sectionTitle: String
    let systemIcon: String
    let content: Content
    @Environment(\.colorScheme) var colorScheme

    init(sectionTitle: String, systemIcon: String, @ViewBuilder content: () -> Content) {
        self.sectionTitle = sectionTitle
        self.systemIcon = systemIcon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: systemIcon)
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(sectionTitle)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding(.bottom, 4)
            content
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(UIColor.systemBackground).opacity(colorScheme == .dark ? 0.7 : 0.9))
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                )
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 2)
    }
}

struct StatBar: View {
    let label: String
    let value: String
    let color: Color

    private var intValue: Int {
        return Int(value) ?? 0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 10)
                        .cornerRadius(5)
                    Rectangle()
                        .fill(color)
                        .frame(width: min(CGFloat(intValue) / 100 * geometry.size.width, geometry.size.width), height: 10)
                        .cornerRadius(5)
                }
            }
            .frame(height: 10)
        }
    }
}

struct StatPill: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 70, height: 70)
        .background(
            Circle()
                .fill(color)
                .shadow(color: color.opacity(0.5), radius: 5, x: 0, y: 3)
        )
    }
}

