//
//  HomeVC.swift
//  HackChallenge
//
//  Created by Ella Krechmer on 4/29/24.
//

import SnapKit
import UIKit

class HomeVC: UIViewController {

    // MARK: - Properties (view)
    private var recipeCollectionView: UICollectionView!

    // MARK: - Properties (data)

    private var allRecipes: [Recipe] = Recipe.dummyData
    private var recipes: [Recipe] = Recipe.dummyData

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        setupRecipeCollectionView()
        
    }

    // MARK: - Set Up Views

    
    private func setupRecipeCollectionView() {
        // Create a FlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12

        // Initialize CollectionView with the layout
        recipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recipeCollectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuse)
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
        recipeCollectionView.alwaysBounceVertical = true
        recipeCollectionView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        recipeCollectionView.showsVerticalScrollIndicator = false

        view.addSubview(recipeCollectionView)

        recipeCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
        }
    }

}

extension HomeVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let detailVC = DetailedRecipeVC(recipe: recipe)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }

}

extension HomeVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuse, for: indexPath) as? RecipeCollectionViewCell {
            let recipe = recipes[indexPath.row]
            cell.configure(recipe: recipe)
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return recipes.count
        

    }

}

extension HomeVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 2 - 16
                    return CGSize(width: size, height: 216)
        
        
    }

}
