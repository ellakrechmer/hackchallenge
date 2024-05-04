//
//  RecipeCollectionViewCell.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 4/29/24.
//

import Foundation
import UIKit
import SDWebImage

class RecipeCollectionViewCell : UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    private let recipeImage = UIImageView()
    private let recipeTitleLabel = UILabel()
    private let recipeSubtitle = UILabel()
    private let likeButton = UIButton()
    private let likeNumberLabel = UILabel()
    
    static let reuse = "RecipeCollectionViewCellReuse"
    
    // MARK: - Properties (data)
//     var imageUrl : String = ""
//     var recipeTitle : String = ""
    private var postId = ""
    private var likeCount = 0
    private var likes : [String] = []
    
    // MARK: - init
    
    // NOTE: Compare init with a `UITableViewCell`
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRecipeImage()
        setupRecipeTitleLabel()
//        setupRecipeSubtitleLabel()
//        setupBookmark()
        setupLikeButton()
        setupLikeNumberLabel()
        
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - configure
    
    func configure(recipe: Recipe) {
        recipeImage.sd_setImage(with: URL(string: recipe.imageUrl))
        recipeTitleLabel.text = recipe.title
        
//        self.imageUrl = recipe.imageUrl
//        self.recipeTitle = recipe.name
        
        likeCount = recipe.likes.count
        likes = recipe.likes
        
        if (!recipe.likes.contains("egk46")){
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor.hackchallenge.lightPurple
        }
        else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = UIColor.hackchallenge.purple
        }
        
        likeNumberLabel.text = String(likeCount)
        
        

    }
    
    // MARK: - Set Up Views
    
    private func setupRecipeImage(){
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.layer.cornerRadius = 16
        
        recipeImage.layer.masksToBounds = true
        
        contentView.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: 148),
            recipeImage.widthAnchor.constraint(equalToConstant: 148)
        ])
    }
    
    private func setupRecipeTitleLabel(){
        recipeTitleLabel.textColor = .black
        recipeTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        recipeTitleLabel.numberOfLines = 2
        
        contentView.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 4),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImage.leadingAnchor, constant: 0),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
//    private func setupRecipeSubtitleLabel(){
//        
//        recipeSubtitle.textColor = UIColor.hackchallenge.silver
//        recipeSubtitle.font = .systemFont(ofSize: 12, weight: .regular)
//        
//        contentView.addSubview(recipeSubtitle)
//        recipeSubtitle.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            recipeSubtitle.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 4),
//            recipeSubtitle.leadingAnchor.constraint(equalTo: recipeTitleLabel.leadingAnchor, constant: 0),
//        ])
//        
//    }
//    
//    private func setupBookmark(){
//        bookmark.image = UIImage(systemName: "bookmark.fill")
//        bookmark.tintColor = UIColor.hackchallenge.purple
//        
//        contentView.addSubview(bookmark)
//        
//        bookmark.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            bookmark.topAnchor.constraint(equalTo: recipeTitleLabel.topAnchor, constant: 0),
//            bookmark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            bookmark.heightAnchor.constraint(equalToConstant: 20),
//            bookmark.widthAnchor.constraint(equalToConstant: 20)
//        ])
//    }
    
    private func setupLikeButton(){
        likeButton.contentMode = .scaleAspectFit
        
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: recipeTitleLabel.leadingAnchor),
            likeButton.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 0),
            likeButton.heightAnchor.constraint(equalToConstant: 24),
            likeButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupLikeNumberLabel(){
        likeNumberLabel.textColor = UIColor.hackchallenge.black
        likeNumberLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        
        contentView.addSubview(likeNumberLabel)
        likeNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeNumberLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            likeNumberLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
}
