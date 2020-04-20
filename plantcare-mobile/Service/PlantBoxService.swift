//
//  PlantBoxClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 15.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct PlantBoxService {
    
    let baseUrlString: String

    init() {
        self.baseUrlString = "https://plantcare.msgis.net/api/data/plantBoxes"
    }
    
    func getPlantBox(withId id: Int, completion: @escaping (Result<PlantBox, WebError>) -> Void) {
        guard let resourceURL = URL(string: "\(baseUrlString)/\(id)")
            else {
                completion(.failure(.unableToCreateUrl))
                return
            }
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let plantBox = try JSONDecoder().decode(PlantBox.self, from: jsonData)
                completion(.success(plantBox))
            } catch {
                completion(.failure(.unableToDecodeData))
            }
        }
        dataTask.resume()
        
    }
    
    func getPlantBoxesForUser(withId id: Int, completion: @escaping (Result<[PlantBox], WebError>) -> Void) {
        guard let resourceURL = URL(string: "\(baseUrlString)?userId=\(id)")
            else {
                completion(.failure(.unableToCreateUrl))
                return
            }
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.unableToObtainData))
                return
            }
            
            do {
                let plantBoxes = try JSONDecoder().decode([PlantBox].self, from: jsonData)
                completion(.success(plantBoxes))
            } catch {
                completion(.failure(.unableToDecodeData))
            }
        }
        dataTask.resume()
    }
    
}
