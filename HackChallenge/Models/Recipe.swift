//
//  Recipe.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 4/29/24.
//

import Foundation

struct CommentsResponse: Codable {
    let comments: [String]
}

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe : Codable {
    let id: Int
    let title: String
    let postDate: Date
    let numberOfLikes: Int
    let userId: Int
    let imageUrl: String
    let recipeComments: [String]
    
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case title = "title"
//        case postDate = "post_date"
//        case numberOfLikes = "number_of_likes"
//        case userId = "user_id"
//        case imageUrl = "image_url"
//        case recipeComments = "recipe_comments"
//        }
}


extension Recipe {
 
    static let dummyData = [
        Recipe(id:1234, title:"Chicken Noodle Soup",postDate: Date(timeIntervalSinceNow: -5), numberOfLikes: 2, userId: 1,  imageUrl: "https://www.inspiredtaste.net/wp-content/uploads/2018/09/Easy-Chicken-Noodle-Soup-Recipe-1-1200.jpg", recipeComments: ["yum","so good"]),
        Recipe(id:5678,title:"Brownies",postDate: Date(timeIntervalSinceNow: -5), numberOfLikes: 2, userId:2, imageUrl: "https://cdn.loveandlemons.com/wp-content/uploads/2020/01/brownie-recipe.jpg",  recipeComments: ["looks delish","amazing"])
    ]
 
}
