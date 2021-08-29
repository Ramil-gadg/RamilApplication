//
//  DetailViewController.swift
//  RamilApplication
//
//  Created by Рамил Гаджиев on 29.08.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var imageString: String?
    
    @IBOutlet var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard imageString != nil else {return}
        if let imageURL = URL(string: imageString!) {
            if let imageData = try? Data(contentsOf: imageURL) {
                detailImage.image = UIImage(data: imageData)
            }
        }
    }
}
