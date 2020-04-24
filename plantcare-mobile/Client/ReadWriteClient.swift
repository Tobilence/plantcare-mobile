
//
//  PostClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

protocol ReadWriteClient: ReadClient {
    
    associatedtype EncodableModel: Encodable
}

extension ReadWriteClient {
    
    func save(_ model: EncodableModel, completion: @escaping (Result<DecodableModel, WebError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: baseUrl())
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(model)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                        let jsonData = data else {
                            completion(.failure(.responseProblem))
                            return
                    }
                do {
                    let userData = try JSONDecoder().decode(DecodableModel.self, from: jsonData)
                    completion(.success(userData))
                } catch {
                    print(model.self)
                    print(error)
                    completion(.failure(.unableToDecodeData))
                    return
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.unableToEncodeData))
        }
    }
}
