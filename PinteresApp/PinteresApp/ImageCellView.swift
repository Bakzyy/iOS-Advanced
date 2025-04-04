//
//  ImageCellView.swift
//  PinteresApp
//
//  Created by Bakustar Zhumadil on 04.04.2025.
//

import SwiftUI

struct ImageCellView: View {
    let imageData: Data
    
    var body: some View {
        if let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(10)
        } else {
            Color.gray
                .frame(height: 200)
                .cornerRadius(10)
        }
    }
}
