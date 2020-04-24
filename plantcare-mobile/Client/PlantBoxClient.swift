//
//  PlantBoxClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 24.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct PlantBoxClient: ReadWriteClient {
    
    var urlName = "plantBoxes"
    typealias Identifier = Int
    typealias DecodableModel = PlantBox
    typealias EncodableModel = PreparedPlantBox
    
    func getAllForUser(withId: Identifier, completion: @escaping (Result<[DecodableModel], WebError>) -> Void){
        guard let url = URL(string: "https://plantcare.msgis.net/api/data/plantBoxes?userId=\(withId)") else {
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {data, _, _ in
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
}
