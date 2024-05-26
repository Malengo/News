//
//  HomeInteractor.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import Foundation

protocol HomeViewBusinessLogic {
    func fecthnews(newsToppic: String)
    func fecthNewsByCategory(newsCategoryToppic: String)
}

class HomeInteractor: HomeViewBusinessLogic {
    
    var worker: HomeWorkerProtocol?
    var workerCategory: NewsByCategoryWorkerProtocol?
    var presenter: HomePresentationLogic?
    
    init(worker: HomeWorkerProtocol, workerCategory: NewsByCategoryWorkerProtocol, presenter: HomePresentationLogic?) {
        self.worker = worker
        self.workerCategory = workerCategory
        self.presenter = presenter
    }
    
    func fecthnews(newsToppic: String) {
        worker?.getAll(newsToppic: newsToppic, { result in
            switch result {
            case .success(let clients):
                let response = HomeModel.GetNews.Response(clients: clients)
                self.presenter?.presentAll(response: response)
            case.failure(let error):
                print(error)
            }
        })
    }
    
    func fecthNewsByCategory(newsCategoryToppic: String) {
        workerCategory?.getAll(newsCategoryToppic: newsCategoryToppic, {
            result in
                switch result {
                case .success(let clients):
                    let response = HomeModel.GetNews.Response(clients: clients)
                    self.presenter?.presentAll(response: response)
                case.failure(let error):
                    print(error)
                }
        })
    }
}
