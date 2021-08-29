//
//  CollectionViewCell.swift
//  RamilApplication
//
//  Created by Рамил Гаджиев on 28.08.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageView: UIImageView!

    func configurateCellImage(with URLString: String) {
        if let imageURL = URL(string: URLString) {
            if let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}

