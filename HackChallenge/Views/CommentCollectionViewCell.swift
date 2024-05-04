//
//  CommentCollectionViewCell.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 5/3/24.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties (view)
    private let messageLabel = UILabel()
    
    // MARK: - Properties (data)
    
    static let reuse = "CommentCollectionViewCellReuse"
    private var comment : String = ""
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.hackchallenge.offWhite
        layer.cornerRadius = 8
        
        setupMessageLabel()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    func configure(comment: String){
//        self.comment = comment
        messageLabel.text = comment
    }
    
    // MARK: - Set Up Views
    private func setupMessageLabel(){
//        messageLabel.text = "hello"
        messageLabel.textColor = UIColor.hackchallenge.black
        messageLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            messageLabel.heightAnchor.constraint(equalToConstant: 48),
            
        ])
    }
    
}
