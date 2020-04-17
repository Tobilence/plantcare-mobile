//
//  UserService.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

enum UserError: Error {
    case userNotFound
    case unableToDecodeData
    case responseProblem
    case unableToEncodeData
    case unableToCreateUrl
}

struct UserService {
    
    let baseUrlString: String
    
    init() {
        self.baseUrlString = "https://plantcare.msgis.net/api/data/users/"
    }
    
    func getUserInformation(forUserId: Int, completion: @escaping (Result<User, UserError>) -> Void) {
        
        guard let resourceURL = URL(string: "\(baseUrlString)\(forUserId)") else {
            completion(.failure(.unableToCreateUrl))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.userNotFound))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: jsonData)
                completion(.success(user))
            } catch {
                completion(.failure(UserError.unableToDecodeData))
            }
        }
        dataTask.resume()
    }
    
    func sendPost (user: User, completion: @escaping (Result<User, UserError>) -> Void) {
        
        do {
            guard let resourceURL = URL(string: "\(baseUrlString)") else {
                completion(.failure(.unableToCreateUrl))
                return
            }
            
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                        let jsonData = data else {
                            completion(.failure(.responseProblem))
                            return
                    }
                do {
                    let userData = try JSONDecoder().decode(User.self, from: jsonData)
                    completion(.success(userData))
                } catch {
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
