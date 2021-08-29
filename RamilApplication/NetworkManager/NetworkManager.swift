//
//  NetworkManager.swift
//  RamilApplication
//
//  Created by Рамил Гаджиев on 28.08.2021.
//

import Foundation
import UIKit

class NetworkManager {
    static var shared = NetworkManager()
    private init() {}
    
    func getImages (with request: String, completion: @escaping (_ json: Model?, _ errorWarning: String?)->()) {
        let urlString = "https://api.unsplash.com/search/photos?query=\(request)&per_page=20&client_id=\(Keys.unsplashKey.rawValue)"
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            session.dataTask(with: url) { data, response, error in
                
                guard error == nil else {
                    let errorDiscription = "Ошибка: \(error?.localizedDescription ?? "произошла непредвиденная ошибка")"
                    completion(nil, errorDiscription)
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    let json = try JSONDecoder().decode(Model.self, from: data)
                    completion(json, nil)
                } catch let error {
                    let errorDiscription = "Ошибка: \(error.localizedDescription)"
                    completion(nil, errorDiscription)
                }
            }.resume()
        }
    }
}


