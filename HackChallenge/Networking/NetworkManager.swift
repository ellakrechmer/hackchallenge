//
//  NetworkManager.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 5/3/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let devEndpoint: String = "http://127.0.0.1:8000"
    
    // MARK: - Requests
    
    func getRecipes(completion: @escaping ([Recipe]) -> Void){
        let endpoint = devEndpoint + "/api/recipes/"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: RecipesResponse.self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let recipesResponse):
                    let recipes = recipesResponse.recipes
                    print("Successfully fetched \(recipes.count) recipes")
                    completion(recipes)
                case .failure(let error):
                    print("Error in NetworkManager.getRecipes: \(error)")
                }
            }
        
    }
    
    func getComments(recipeId:Int, completion: @escaping ([String]) -> Void){
        let endpoint = devEndpoint + "/api/recipes/\(recipeId)comments/"
        
        let decoder = JSONDecoder()
        
        AF.request(endpoint, method: .get).validate().responseDecodable(of: CommentsResponse.self, decoder: decoder){ response in
            switch response.result {
            case .success(let commentsResponse):
                let comments = commentsResponse.comments
                print("Successfully fetched \(comments.count) comments")
                completion(comments)
            case .failure(let error):
                print("Error in NetworkManager.getRecipes: \(error)")
            }
            
        }
    }
    
    func createComment(message: String, userId: Int, recipeId: Int, completion: @escaping (String) -> Void){
        // Specify the endpoint
        let endpoint = devEndpoint+"/api/users/\(userId)/recipes/\(recipeId)/comments/"
        
        // Define the request body
        let parameters: Parameters = [
            "text": message,
            "post_date": Date().description
        ]
        
        // Create a decoder
        let decoder = JSONDecoder()
        
        // Create the request
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: String.self, decoder: decoder){
            response in
            // Handle the response
            switch response.result {
            case .success(let message):
                print("Successfully added comment \(message)")
                completion(message)
            case .failure(let error):
                print("Error in NetworkManager.createPost: \(error)")
            }

        }
        
    }
    
    
}
