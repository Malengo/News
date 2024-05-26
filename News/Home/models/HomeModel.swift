//
//  HomeModel.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import Foundation

enum HomeModel {
    enum GetNews {
        struct Request{}
        
        struct Response {
            var clients: [Article]
        }
        
        struct ViewModel {
            var newsList: [Article]
        }
    }
}
