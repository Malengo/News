//
//  NewsCategoryCell.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import UIKit

class NewsCategoryCell: UICollectionViewCell, ViewCodeProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var stackCategory: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        return stack
    }()
    
    private(set) lazy var imageCategory: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chair")
        image.backgroundColor = .systemGray6
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.contentMode = .center
        image.tintColor = .black
        return image
    }()
    
    private(set) lazy var labelCategory: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .center
        label.font = label.font.withSize(13)
        label.numberOfLines = 0
        return label
    }()
    
    func buildViewHierachy() {
        addSubview(stackCategory)
        stackCategory.addArrangedSubview(imageCategory)
        stackCategory.addArrangedSubview(labelCategory)
    }
    
    func setupConstraints() {
        imageCategory.translatesAutoresizingMaskIntoConstraints = false
        stackCategory.translatesAutoresizingMaskIntoConstraints = false
        
        stackCategory.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackCategory.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stackCategory.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    func addictionalConfiguration() {
    }
    


}

