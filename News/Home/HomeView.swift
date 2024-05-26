//
//  HomeView.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import UIKit

class HomeView: UIView, ViewCodeProtocol {
    
    private(set) lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Digite o tema da notícia!"
        return search
    }()
    
    private(set) lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 5
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collection.clipsToBounds = true
        collection.layer.cornerRadius = 8
        collection.register(NewsCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    
    private(set) lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.clipsToBounds = true
        collection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collection.layer.cornerRadius = 18
        collection.register(NewsCategoryCell.self, forCellWithReuseIdentifier: "newsCategoryCell")
        return collection
    }()
    
    func buildViewHierachy() {
        addSubview(searchBar)
        addSubview(categoryCollectionView)
        addSubview(collection)
    }
    
    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        searchBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        categoryCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 10).isActive = true
        collection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        collection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    }
    
    func addictionalConfiguration() {
        backgroundColor = .white
    }
}
