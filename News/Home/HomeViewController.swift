//
//  HomeViewController.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import UIKit

protocol HomeDisplayLogic {
    func displayAllNews(viewModel: HomeModel.GetNews.ViewModel)
}

class HomeViewController: UIViewController {
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    // MARK: - VIP
    var interactor: HomeViewBusinessLogic?
    var presenter: HomePresentationLogic?
    var news: [Article] = []
    
    let newsCategoryList: [NewsCategory] = [
        NewsCategory(typeCategory: "business", imageCategory: "creditcard"),
        NewsCategory(typeCategory: "entertainment", imageCategory: "person"),
        NewsCategory(typeCategory: "general", imageCategory:"briefcase"),
        NewsCategory(typeCategory: "health", imageCategory: "heart"),
        NewsCategory(typeCategory: "science", imageCategory: "exclamationmark.octagon"),
        NewsCategory(typeCategory: "sports", imageCategory: "sportscourt"),
        NewsCategory(typeCategory: "technology", imageCategory: "burn")
    ]
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        setupDelegates()
        interactor?.fecthnews(newsToppic: "Brasil")
    }
    
    override func loadView() {
        homeView.setupView()
        view = homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationItem.title = ""
    }
    
    // MARK: - private Methods
    private func setupVIP() {
        presenter = HomePresenter(view: self)
        interactor = HomeInteractor(worker: HomeWorker(), workerCategory: NewsByCategoryWorker(), presenter: presenter)
    }
    
    private func setupDelegates() {
        homeView.searchBar.delegate = self
        homeView.collection.delegate = self
        homeView.collection.dataSource = self
        homeView.categoryCollectionView.delegate = self
        homeView.categoryCollectionView.dataSource = self
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayAllNews(viewModel: HomeModel.GetNews.ViewModel) {
        news = viewModel.newsList
        DispatchQueue.main.async {
            self.homeView.collection.reloadData()
        }
        
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let newsText = searchBar.text {
            interactor?.fecthnews(newsToppic: newsText)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.collection {
            return news.count
        } else {
            return newsCategoryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.collection {
            return setupNewsCollectionView(collectionView: collectionView, indexPath: indexPath)
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCategoryCell", for: indexPath) as? NewsCategoryCell  else {
                return UICollectionViewCell()
            }
            let category = newsCategoryList[indexPath.row]
            cell.imageCategory.image = UIImage(systemName: category.imageCategory)
            cell.labelCategory.text = category.typeCategory
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       /* if collectionView == homeView.collection {
            let newsViewController = NewsViewController()
            newsViewController.news = self.news[indexPath.row]
            navigationController?.pushViewController(newsViewController, animated: true)
        } else {
            interactor?.fecthNewsByCategory(newsCategoryToppic: newsCategoryList[indexPath.row].typeCategory)
        }
        */
    }
    
    private func setupNewsCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCell  else {
            return UICollectionViewCell()
        }
        let article: Article = news[indexPath.row]
        let image: UIImageView = UIImageView()
        image.clipsToBounds = false
        if let urlToImage =    article.urlToImage
        {
            Task {
                let (data, _) = try await URLSession.shared.data(from: URL(string: urlToImage)!)
                image.image = UIImage(data: data)
                image.contentMode = .scaleToFill
            }
        } else {
            image.image = UIImage(systemName: "eye")
            image.contentMode = .center
            
        }
        cell.backgroundView = image
        cell.newsTitle.text = article.title
        cell.newsAuthor.text = article.author
        cell.newsDescription.text = article.description
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == homeView.collection ? CGSize(width: collectionView.bounds.width / 2.2, height: 240) : CGSize(width: 120, height: 120)
    }
    
}
