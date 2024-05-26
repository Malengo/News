//
//  NewsCell.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import UIKit

class NewsCell: UICollectionViewCell, ViewCodeProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 4
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private(set) lazy var newsAuthor: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .systemBlue
        label.font = label.font.withSize(15)
        return label
    }()
    
    private(set) lazy var newsDescription: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        return label
    }()
    
    private(set) lazy var stackInformation: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .lastBaseline
        stack.spacing = 5
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        stack.backgroundColor = .white.withAlphaComponent(0.8)
        return stack
    }()
    
    func buildViewHierachy() {
        addSubview(stackInformation)
        stackInformation.addArrangedSubview(newsTitle)
        stackInformation.addArrangedSubview(newsAuthor)
        stackInformation.addArrangedSubview(newsDescription)
    }
    
    func setupConstraints() {
        stackInformation.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        stackInformation.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        stackInformation.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func addictionalConfiguration() {
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
}
