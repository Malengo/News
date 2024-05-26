//
//  NewByCategoryWorker.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import Foundation

protocol NewsByCategoryWorkerProtocol {
    func getAll(newsCategoryToppic: String, _ completion: @escaping (Result<[Article], ResponseError>) -> ())
}
class NewsByCategoryWorker: NewsByCategoryWorkerProtocol, RequestApiProtocol {
    
    var urlRequest: URL?
    var request: URLRequest?
    var data: Data?
    
    typealias RequestApi = Any
    typealias ResponseApi = [Article]
    
    func validUrl() throws {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else {
            throw ResponseError.invalidUrl
        }
        urlRequest = url
    }
    
    func setupRequest(_ requestApi: RequestApi) throws {
        guard let url = urlRequest else { throw  ResponseError.invalidUrl }
        var setupRequest = URLRequest(url: url)
        setupRequest.url?.append(queryItems: [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "category", value: requestApi as? String),
            URLQueryItem(name: "apiKey", value: "c80e1f7d0cb64b7aa09edff18d463412")
        ])
        setupRequest.httpMethod = "GET"
        request = setupRequest
    }
    
    func getData(_ completion: ([Article]) -> ()) async throws {
        do {
            let (data, response) = try await URLSession.shared.data(for: request!)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ResponseError.invalidData
            }
            
            guard httpResponse.statusCode == 200 else {
                throw ResponseError.httpStatusCodeError(httpResponse.statusCode)
            }
            
            let clients = try JSONDecoder().decode(DataResponse.self, from: data).articles.map({ $0 as Article })
            completion(clients)
        } catch let error {
            throw error is DecodingError ? ResponseError.decodeError : ResponseError.invalidUrl
        }
    }
    
    func getAll(newsCategoryToppic: String, _ completion: @escaping (Result<[Article], ResponseError>) -> ()) {
        Task {
            do {
                try await callApi(request: newsCategoryToppic) { newsCategoryToppic in
                    completion(.success(newsCategoryToppic))
                }
            } catch let error as ResponseError {
                completion(.failure(error))
            }
        }
    }
    
    
}
