//
//  RetrieveDataClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 20.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

protocol RetrieveDataClient: WebClient {
    
    associatedtype ModelType: Decodable
    
}

extension RetrieveDataClient {
    
    func getAll(completion: @escaping (Result<ModelType, WebError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
            guard let jsonData = data else {
                print("error getting data from api")
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([ModelType].self, from: jsonData)
                completion(.success(response))
            } catch {
                print("error trying to decode json data: \(error)")
            }
        }
        dataTask.resume()
    }
}
