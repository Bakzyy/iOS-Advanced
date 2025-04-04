//
//  ContentView.swift
//  PinteresApp
//
//  Created by Bakustar Zhumadil on 04.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageGalleryViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.images) { imageModel in
                        ImageCellView(imageData: imageModel.imageData)
                            .frame(height: 200)
                    }
                }
                .padding()
            }
            .navigationTitle("Pinterest Gallery")
            .toolbar {
                Button("Add 5") {
                    viewModel.fetchRandomImages()
                }
            }
        }
    }
}

