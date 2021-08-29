//
//  CollectionViewController.swift
//  RamilApplication
//
//  Created by Рамил Гаджиев on 28.08.2021.
//

import UIKit



class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images = [String]()
    var textFromTextField: String?
    private let horizontalInset: CGFloat = 15
    private let verticalInset: CGFloat = 15
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        images = [String]()
        if let request = textFromTextField {
            getImagesOnRequest(with: request)
        }
        
    }
    
    func getImagesOnRequest (with request: String) {
        NetworkManager.shared.getImages(with: request) {[weak self] (json, errorWarning) in
            if json != nil {
                for result in json!.results {
                    self?.images.append(result.urls.regular)
                }
                DispatchQueue.main.async {
                    self?.indicator.stopAnimating()
                    self?.collectionView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Ошибка", message: errorWarning!)
                    self?.indicator.stopAnimating()
                }
            }
        }
        
    }
    
    
  
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! CollectionViewCell
        
        let urlStringForImage = images[indexPath.item]
        cell.configurateCellImage(with: urlStringForImage)
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
            vc.imageString = images[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnCount: CGFloat = 3
        let horizontalInsetCount = columnCount + 1
        let cellWidth = (collectionView.frame.width - horizontalInsetCount * horizontalInset) / columnCount
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
}

// MARK: - Alert
extension CollectionViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
        indicator.stopAnimating()
    }
}

