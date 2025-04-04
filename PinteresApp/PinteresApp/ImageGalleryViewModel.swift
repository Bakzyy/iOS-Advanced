//
//  ImageGalleryViewModel.swift
//  PinteresApp
//
//  Created by Bakustar Zhumadil on 04.04.2025.
//

import Foundation

class ImageGalleryViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    
    func fetchRandomImages(count: Int = 5) {
        let dispatchGroup = DispatchGroup()
        var newImages: [ImageModel] = []
        
        for _ in 0..<count {
            dispatchGroup.enter()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let imageUrl = URL(string: "https://picsum.photos/300/400")!
                
                if let data = try? Data(contentsOf: imageUrl) {
                    let model = ImageModel(url: imageUrl, imageData: data)
                    newImages.append(model)
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.images.append(contentsOf: newImages)
        }
    }
}

