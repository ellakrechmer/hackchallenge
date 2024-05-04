//
//  Recipe.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 4/29/24.
//

import Foundation

struct Recipe : Codable {
    let id: Int
    let title: String
    let postDate: Date
    let likes: [String]
    let numLikes: Int
    let comments: [String]
    let imageUrl: String
    let userId: Int
}


extension Recipe {
 
    static let dummyData = [
        Recipe(id:1234,title:"Chicken Noodle Soup",postDate: Date(timeIntervalSinceNow: -5), likes: ["egk46", "act238"],numLikes: 2, comments: ["yum","so good"], imageUrl: "https://www.inspiredtaste.net/wp-content/uploads/2018/09/Easy-Chicken-Noodle-Soup-Recipe-1-1200.jpg", userId: 1),
        Recipe(id:5678,title:"Brownies",postDate: Date(timeIntervalSinceNow: -5), likes: ["iat24", "act238"],numLikes: 2, comments: ["yum","so good"], imageUrl: "https://cdn.loveandlemons.com/wp-content/uploads/2020/01/brownie-recipe.jpg", userId:2)
    ]
 
}
