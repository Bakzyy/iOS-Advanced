//
//  ImageModel.swift
//  PinteresApp
//
//  Created by Bakustar Zhumadil on 04.04.2025.
//

import Foundation

struct ImageModel: Identifiable {
    let id = UUID()
    let url: URL
    let imageData: Data
}

