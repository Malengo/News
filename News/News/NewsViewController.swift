//
//  NewsViewController.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import UIKit

class NewsViewController: UIViewController , UINavigationControllerDelegate {
    
    var news: Article?
    
    lazy var newsView: NewsView = {
        let view = NewsView()
        return view
    }()
    
    override func loadView() {
        newsView.setupView()
        view = newsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupContent()
    }
    
    private func setupContent() {
        newsView.newsContent.text = news?.content
        newsView.newsAuthor.text = news?.author
        newsView.newsDate.text = Date().formatedDate(formated: news?.publishedAt ?? "")
        if let urlToImage = news?.urlToImage
        {
            Task {
                let (data, _) = try await URLSession.shared.data(from: URL(string: urlToImage)!)
                newsView.imageHeader.image = UIImage(data: data)
            }
        }
        newsView.newsTitle.text = news?.title
    }
}
