//
//  HomeViewControllerTest.swift
//  NewsTests
//
//  Created by Malengo on 04/06/24.
//

import XCTest
@testable import News

final class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController!
    var homeView: HomeViewMock!
    var interactor: HomeViewBusinessLogicMock!
    var navigationController: UINavigationControllerSpy!

    override func setUpWithError() throws {
        sut = HomeViewController()
        homeView = HomeViewMock()
        interactor = HomeViewBusinessLogicMock()
        navigationController = UINavigationControllerSpy(rootViewController: sut)
    }

    override func tearDownWithError() throws {
        sut = nil
        homeView = nil
        interactor = nil
        navigationController = nil
    }
    
    func testLoadViewMustCallSetupView() {
        //Given
        sut.homeView = homeView
        
        //When
        sut.loadView()
        
        //Then
        XCTAssertTrue(homeView.wasBuildViewHierachyCalled)
        XCTAssertTrue(homeView.wasAddictionalConfigurationCalled)
        XCTAssertTrue(homeView.wasSetupConstraintCalled)
    }
    
    func testViewDidLoadMustSetupVIP() {
        //Given
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertTrue(sut?.interactor is HomeViewBusinessLogic)
        XCTAssertTrue(sut?.presenter is HomePresentationLogic)
    }
    
    func testViewDidLoadMustConfigDelegatesAndDatasource() {
        //Given
        sut.homeView = homeView
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertTrue(sut.homeView.searchBar.delegate is HomeViewController)
        XCTAssertTrue(sut.homeView.collection.delegate is HomeViewController)
        XCTAssertTrue(sut.homeView.collection.dataSource is HomeViewController)
        XCTAssertTrue(sut.homeView.categoryCollectionView.delegate is HomeViewController)
        XCTAssertTrue(sut.homeView.categoryCollectionView.dataSource is HomeViewController)
    }
    
    func testViewWillAppearMustCallFecthnews() {
        //Given
        sut.interactor = interactor
        
        //When
        sut.viewWillAppear(true)
        
        
        //Then
        XCTAssertTrue(interactor.wasFetchNewsCalled)
    }
    
    func testViewDidDisappearMustSetNavigationtitleEmpty() {
        //Given
        sut.navigationItem.title = "Teste"
        
        //When
        sut.viewDidDisappear(true)
        
        //Then
        XCTAssertEqual(sut.navigationItem.title, "", "The title must be empty")
    }
    
    func testDisplayAllNewsMustSetValueInNews() {
        //Given
        let articleList = [
            Article(author: "Test", title: "Title Test", description: "Teste description", url: "http://test.com", urlToImage: "http://test-image.com", publishedAt: Date.now.description, content: "Test content"),
            Article(author: "Test 1", title: "Title Test 1", description: "Teste description 1", url: "http://test.com/1", urlToImage: "http://test-image.com/1", publishedAt: Date.now.description, content: "Test content/1"),
        ]
        
        let viewModel = HomeModel.GetNews.ViewModel(newsList: articleList)
        
        //When
        sut.displayAllNews(viewModel: viewModel)
        
        //Then
        XCTAssertFalse(sut.news.isEmpty, "The news must have a value")
        XCTAssertEqual(sut.news.count, articleList.count, "The news list must have \(articleList.count) values" )
        
    }
    
    func testcategoryCollectionViewDidSelectItemAtMustCallFetchNewsByCategoryWhenCollectionViewIsCategory() {
        //Given
        sut.interactor = interactor
        
        //When
        sut.collectionView(sut.homeView.categoryCollectionView, didSelectItemAt: IndexPath(row: 1, section: 1))
        
        //Then
        XCTAssertTrue(interactor.wasFetchNewsByCategoryCalled, "Must call fetchnewsbycategory")
    }
    
    func testCategoryCollectionViewDidSelectItemAtMustCallPushViewController() {
        //Given
        sut.news = [
            Article(author: "Test", title: "Title Test", description: "Teste description", url: "http://test.com", urlToImage: "http://test-image.com", publishedAt: Date.now.description, content: "Test content"),
            Article(author: "Test 1", title: "Title Test 1", description: "Teste description 1", url: "http://test.com/1", urlToImage: "http://test-image.com/1", publishedAt: Date.now.description, content: "Test content/1"),
        ]
        
        //When
        sut.collectionView(sut.homeView.collection, didSelectItemAt: IndexPath(row: 1, section: 1))
        
        //
        navigationController.pushViewControllerHandler = { viewController, animated in
            XCTAssertTrue(viewController is NewsViewController)
            XCTAssertTrue(animated)
            if let newsViewController = viewController as? NewsViewController {
                XCTAssertEqual(newsViewController.news, self.sut.news[1])
            }
        }
    }
    
    func testCategoryCollectionViewDidSelectItemAtMustCallPushViewControllerAndSetupNewsViewController() {
        //Given
        sut.news = [
            Article(author: "Test", title: "Title Test", description: "Teste description", url: "http://test.com", urlToImage: "http://test-image.com", publishedAt: Date.now.description, content: "Test content"),
            Article(author: "Test 1", title: "Title Test 1", description: "Teste description 1", url: "http://test.com/1", urlToImage: "http://test-image.com/1", publishedAt: Date.now.description, content: "Test content/1"),
        ]
        
        //When
        sut.collectionView(sut.homeView.collection, didSelectItemAt: IndexPath(row: 1, section: 1))
        
        //
        navigationController.pushViewControllerHandler = { viewController, animated in
            if let newsViewController = viewController as? NewsViewController {
                XCTAssertNotNil(newsViewController.news, "The news must have a value")
                XCTAssertEqual(newsViewController.news, self.sut.news[1])
            }
        }
    }

}
