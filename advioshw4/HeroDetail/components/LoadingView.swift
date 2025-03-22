//
//  LoadingView.swift
//  advioshw4
//
//  Created by Dias Jakupov on 22.03.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            Text("Loading hero details...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}
