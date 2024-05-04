//
//  DetailedRecipeVC.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 4/29/24.
//

import UIKit
import SDWebImage


class DetailedRecipeVC : UIViewController {
    
    // MARK: - Properties (view)
    private let recipeImageView = UIImageView()
    private let recipeTitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let commentLabel = UILabel()
    private var commentCollectionView : UICollectionView!
    
    
    // MARK: - Properties (data)
    private let recipe : Recipe
    private let comments : [String]
    private let date : String
    private let userId : Int
    private let recipeId : Int
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.hackchallenge.white
        
        setupRecipeImageView()
        setupRecipeTitleLabel()
        setupDateLabel()
        setupCommentLabel()
        setupCommentCollectionView()
        
    }
    
    init(recipe: Recipe){
        self.recipe = recipe
        self.comments = recipe.comments
        self.date = Date.convertToAgo(recipe.postDate)()
        self.userId = recipe.userId
        self.recipeId = recipe.id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    
    private func setupRecipeImageView(){
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 16
        recipeImageView.sd_setImage(with: URL(string: recipe.imageUrl))
        
        recipeImageView.layer.masksToBounds = true
        
        view.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -32),
            recipeImageView.heightAnchor.constraint(equalToConstant: 329),
            recipeImageView.widthAnchor.constraint(equalToConstant: 329)
        ])
        
    }
    
    private func setupRecipeTitleLabel(){
        recipeTitleLabel.textColor = UIColor.hackchallenge.black
        recipeTitleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.text = recipe.title
        
        view.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 32),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
        ])
    }
    
    private func setupDateLabel(){
        dateLabel.textColor = UIColor.hackchallenge.black
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.text = "Posted \(date)"
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 32),
            dateLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 12)
        ])
    }
    
    private func setupCommentLabel(){
        commentLabel.textColor = UIColor.hackchallenge.black
        commentLabel.font = .italicSystemFont(ofSize: 16)
        commentLabel.text = "Comments"
        
        view.addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            commentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 32),
            commentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private func setupCommentCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        // Initialize CollectionView with the layout
        commentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        commentCollectionView.backgroundColor = UIColor.hackchallenge.white
        commentCollectionView.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: CommentCollectionViewCell.reuse)
        commentCollectionView.register(CreateCommentCollectionViewCell.self, forCellWithReuseIdentifier: CreateCommentCollectionViewCell.reuse)
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
        view.addSubview(commentCollectionView)
        
        commentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentCollectionView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 16),
            commentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

// MARK: - UICollectionViewDelegate

extension DetailedRecipeVC: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension DetailedRecipeVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Return the cells for each section
        // HINT: Use `indexPath.section` with an if statement
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateCommentCollectionViewCell.reuse, for: indexPath) as? CreateCommentCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(userId: userId, recipeId: recipeId)

            return cell
            
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCollectionViewCell.reuse, for: indexPath) as? CommentCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(comment: comments[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of rows for each section
        // HINT: Use `section` with an if statement
        if section == 0 {
            return 1
        }
        else {
            return comments.count
        }

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return the number of sections in this table view

        return 2 // Replace this line
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Return the inset for the spacing between the two sections

        return UIEdgeInsets(top: 0, left: 32, bottom: 32, right: 32) // Replace this line
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailedRecipeVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size for each cell per section
        // HINT: Use `indexPath.section` with an if statement
        if indexPath.section == 0 {
            return CGSize(width: 329, height: 128)
        }
        else {
            return CGSize(width: 329, height: 48)
        }
    }

}

