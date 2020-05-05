//
//  GetClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

protocol ReadClient: WebClient {
    
    var urlName: String { get }
    associatedtype DecodableModel: Decodable
}

extension ReadClient {
    
    func getAll(completion: @escaping (Result<[DecodableModel], WebError>) -> Void) {
        let url = baseUrl()
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                print("error getting data from api")
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([DecodableModel].self, from: jsonData)
                completion(.success(response))
            } catch {
                print("error trying to decode json data: \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    func getById(id: Identifier, completion: @escaping (Result<DecodableModel, WebError>) -> Void) {
        
        let url = specificUrl(id: id)
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                print("error getting data from api")
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DecodableModel.self, from: jsonData)
                completion(.success(response))
            } catch {
                print("error trying to decode json data: \(error)")
            }
        }
        dataTask.resume()
    }
}
