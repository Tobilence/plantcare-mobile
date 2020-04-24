//
//  WebClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 20.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

protocol WebClient {
    
    associatedtype DecodableModel: Decodable
    associatedtype EncodableModel: Encodable
    associatedtype Identifier
    
    var resourceUrl: URL { get set }
    
    func getSpecificUrl(id: Identifier) -> URL
}

extension WebClient {
    
    func getAll(completion: @escaping (Result<[DecodableModel], WebError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) {data, _, _ in
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
        
        let specificUrl = getSpecificUrl(id: id)
        let dataTask = URLSession.shared.dataTask(with: specificUrl) {data, _, _ in
            guard let jsonData = data else {
                print("unable")
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(DecodableModel.self, from: jsonData)
                completion(.success(result))
            } catch {
                print(specificUrl.absoluteString)
                print(error)
                completion(.failure(.unableToDecodeData))
            }
        }
        dataTask.resume()
    }
    
    func save (model: EncodableModel, completion: @escaping (Result<DecodableModel, WebError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceUrl)
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
