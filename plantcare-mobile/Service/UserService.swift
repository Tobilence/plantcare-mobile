//
//  UserService.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 14.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

class UserService : AbstractClient<User>{
    
    init() {
        super.init(urlEnding: "/user")
    }
    
    func sendPost (user: User, completion: @escaping (Result<User, WebError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceUrl)
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
