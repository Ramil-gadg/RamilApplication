//
//  Model.swift
//  RamilApplication
//
//  Created by Рамил Гаджиев on 28.08.2021.
//

import Foundation


struct Model: Codable {
    let results: [Result]
}

struct Result: Codable {
    let urls: Urls
    
}

struct Urls: Codable {
    let regular: String
}

