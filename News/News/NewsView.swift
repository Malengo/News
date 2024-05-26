//
//  NewsView.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import UIKit

class NewsView: UIView, ViewCodeProtocol {
    
    
    private(set) lazy var stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleToFill
        return stack
    }()
    
    private(set) lazy var imageHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleToFill
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return imageView
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentOffset.x = 0
        scroll.clipsToBounds = true
        scroll.layer.cornerRadius = 25
        scroll.backgroundColor = .white
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private(set) lazy var stackHeaderContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .fill
        return stack
    }()
    
    private(set) lazy var newsContent: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var newsAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = .black
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var newsDate: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray6
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    func buildViewHierachy() {
        addSubview(stackHeader)
        addSubview(scrollView)
        stackHeader.addArrangedSubview(imageHeader)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackHeaderContent)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsContent)
        stackHeaderContent.addArrangedSubview(newsAuthor)
        stackHeaderContent.addArrangedSubview(newsDate)
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackHeaderContent.translatesAutoresizingMaskIntoConstraints = false
        stackHeader.translatesAutoresizingMaskIntoConstraints = false
        newsAuthor.translatesAutoresizingMaskIntoConstraints = false
        newsDate.translatesAutoresizingMaskIntoConstraints = false
        imageHeader.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        
        stackHeader.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackHeader.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackHeader.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackHeader.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: stackHeader.bottomAnchor, constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        stackHeaderContent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        stackHeaderContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        stackHeaderContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
       
        newsContent.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 20).isActive = true
        newsContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        newsContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        newsAuthor.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newsAuthor.widthAnchor.constraint(equalToConstant: 160).isActive = true

        newsDate.leadingAnchor.constraint(equalTo: newsAuthor.trailingAnchor, constant: 80).isActive = true
        
        imageHeader.topAnchor.constraint(equalTo: stackHeader.topAnchor).isActive = true
        imageHeader.bottomAnchor.constraint(equalTo: stackHeader.bottomAnchor).isActive = true
        imageHeader.leadingAnchor.constraint(equalTo: stackHeader.leadingAnchor).isActive = true
        imageHeader.trailingAnchor.constraint(equalTo: stackHeader.trailingAnchor).isActive = true
        
        newsTitle.topAnchor.constraint(equalTo: stackHeaderContent.bottomAnchor, constant: 10).isActive = true
        newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func addictionalConfiguration() {
        backgroundColor = .white
    }
    
    
}
