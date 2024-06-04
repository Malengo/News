//
//  HomeViewBusinessLogicMock.swift
//  NewsTests
//
//  Created by Malengo on 04/06/24.
//

import Foundation
@testable import News

class HomeViewBusinessLogicMock: HomeViewBusinessLogic {
    
    var wasFetchNewsCalled = false
    var wasFetchNewsByCategoryCalled = false
    
    func fecthnews(newsToppic: String) {
        wasFetchNewsCalled = true
    }
    
    func fecthNewsByCategory(newsCategoryToppic: String) {
        wasFetchNewsByCategoryCalled = true
    }
    
    
}
