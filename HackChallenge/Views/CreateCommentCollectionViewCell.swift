//
//  CreateRecipeCollectionViewCell.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 5/3/24.
//

import UIKit

class CreateCommentCollectionViewCell : UICollectionViewCell {
    // MARK: - Properties (view)

    private let commentButton = UIButton()
    private let textField = UITextField()

    // MARK: - Properties (data)

    static let reuse: String = "CreateCommentCollectionViewCellReuse"
    private var userId : Int = 0
    private var recipeId : Int = 0
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.hackchallenge.offWhite
        layer.cornerRadius = 8

        setupTextField()
        setupCommentButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(userId: Int, recipeId: Int){
        self.userId = userId
        self.recipeId = recipeId
    }

    // MARK: - Set Up Views

    private func setupTextField() {
        textField.placeholder = "Add a comment..."
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.hackchallenge.offWhite

        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        let sidePadding: CGFloat = 24
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sidePadding)
        ])
    }

    private func setupCommentButton() {
        commentButton.backgroundColor = UIColor.hackchallenge.purple
        commentButton.layer.cornerRadius = 4
        commentButton.setTitle("Comment", for: .normal)
        commentButton.setTitleColor(UIColor.hackchallenge.white, for: .normal)
        commentButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        commentButton.addTarget(self, action: #selector(createComment), for: .touchUpInside)

        contentView.addSubview(commentButton)
        commentButton.translatesAutoresizingMaskIntoConstraints = false

        let sidePadding: CGFloat = 24
        NSLayoutConstraint.activate([
            commentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            commentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -sidePadding),
            commentButton.widthAnchor.constraint(equalToConstant: 96),
            commentButton.heightAnchor.constraint(equalToConstant: 32),
            commentButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32)
        ])
    }

    // MARK: - Button Helpers

    @objc private func createComment() {
        // Send a POST request to create a comment
        let message = textField.text ?? ""
        
        print("userId \(userId)")
        print("recipeId \(recipeId)")
        
        
        NetworkManager.shared.createComment(message: message, userId: userId, recipeId: recipeId ) { comment in
    
            
        }
        
        textField.text = ""
        textField.placeholder = "Add a comment..."
    }

}
