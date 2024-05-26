//
//  HomeWorker.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import Foundation

protocol HomeWorkerProtocol {
    func getAll(newsToppic: String, _ completion: @escaping (Result<[Article], ResponseError>) -> ())
}

class HomeWorker: HomeWorkerProtocol, RequestApiProtocol {
    
    typealias RequestApi = Any
    typealias ResponseApi = [Article]
    var urlRequest: URL?
    var request: URLRequest?
    var data: Data?
    
    // MARK: - RequestApiProtocol
    func validUrl() throws {
        guard let url = Foundation.URL(string: "https://newsapi.org/v2/everything") else {
            throw ResponseError.invalidUrl
        }
        urlRequest = url
    }
    
    func setupRequest(_ requestApi: RequestApi) throws {
        guard let url = urlRequest else { throw ResponseError.invalidUrl }
        var setupRequest = URLRequest(url: url)
        setupRequest.url?.append(queryItems: [
            URLQueryItem(name:  "q" , value: requestApi as? String),
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
    
    // MARK: - HomeWorkerProtocol
    func getAll(newsToppic: String, _ completion: @escaping (Result<[Article], ResponseError>) -> ()) {
        Task {
            do {
                try await callApi(request: newsToppic) { news in
                    completion(.success(news))
                }
            } catch let error as ResponseError {
                completion(.failure(error))
            }
        }
    }
}
