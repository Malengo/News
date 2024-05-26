//
//  HomePresenter.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import Foundation


protocol HomePresentationLogic {
    func presentAll(response: HomeModel.GetNews.Response)
}

class HomePresenter: HomePresentationLogic {
    var view: HomeDisplayLogic?
    
    init(view: HomeDisplayLogic?) {
        self.view = view
    }
    
    func presentAll(response: HomeModel.GetNews.Response) {
        let viewModel = HomeModel.GetNews.ViewModel(newsList: response.clients)
        view?.displayAllNews(viewModel: viewModel)
    }
}
