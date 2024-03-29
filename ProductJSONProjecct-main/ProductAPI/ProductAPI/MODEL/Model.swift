//
//  Model.swift
//  ProductAPI
//
//  Created by Rakesh Kumar Sahoo on 04/03/24.
//

import Foundation

enum UserPostServiceError: Error {
    case invalidUrl
    case noData
    case decodingError
}

struct UserProduct: Codable {
    var products: [UserPost]
}

struct UserPost: Codable {
    var id: Int
    var title: String
    var description : String
    var price : Int
    var discountPercentage : Double
    var rating : Double
    var stock : Int
    var brand : String
    var category : String
    var thumbnail : String
    var images : [String]
    
}

class GetProductApi {
    
    static let shared = GetProductApi()
    init() { }
    
    var urlString = "https://dummyjson.com/products"
    
    func getAllPosts(completion: @escaping(Result<UserProduct, UserPostServiceError>) -> Void) {
        let urlSession = URLSession.shared
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.decodingError))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let posts = try JSONDecoder().decode(UserProduct.self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}


