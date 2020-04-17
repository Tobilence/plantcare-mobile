//
//  PlantRequest.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 13.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

enum PlantError: Error {
    case noDataAvailable
}

struct PlantService {
    
    let resourceURL:URL
    
    init() {
        guard let resourceURL = URL(string: "https://plantcare.msgis.net/api/data/plants") else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func getAllPlants(completion: @escaping (Result<[Plant], PlantError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                print("error getting plants from api")
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let plantResponse = try decoder.decode([Plant].self, from: jsonData)
                completion(.success(plantResponse))
            } catch {
                print("from catch block \(error)")
            }
        }
        dataTask.resume()
    }
}
