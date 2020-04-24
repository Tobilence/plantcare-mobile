//
//  AbstractClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 20.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

class AbstractClient<T : Codable> {
    
    private let baseUrl = "https://plantcare.msgis.net/api/data"
    let resourceUrl: URL
    
    init(urlEnding: String) {
        guard let resourceUrl = URL(string: baseUrl + urlEnding) else {
            print("could not create url")
            fatalError()
        }
        self.resourceUrl = resourceUrl
    }
    
    func getAll(completion: @escaping (Result<[T], WebError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
            guard let jsonData = data else {
                print("error getting data from api")
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([T].self, from: jsonData)
                completion(.success(response))
            } catch {
                print("error trying to decode json data: \(error)")
            }
        }
        dataTask.resume()
    }
    
    func getById(id: Int, completion: @escaping (Result<T, WebError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: jsonData)
                completion(.success(result))
            } catch {
                completion(.failure(.unableToDecodeData))
            }
        }
        dataTask.resume()
    }
}
