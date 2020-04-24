//
//  PlantBoxClient.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 20.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct PlantBoxClient: WebClient {
    
    typealias DecodableModel = PlantBox
    typealias EncodableModel = PreparedPlantBox
    typealias Identifier = Int
    
    var resourceUrl: URL
    
    init() {
        guard let resourceUrl = URL(string: "https://plantcare.msgis.net/api/data/plantBoxes") else {
            fatalError()
        }
        self.resourceUrl = resourceUrl
    }
    
    func getSpecificUrl(id: Int) -> URL {
        guard let resourceUrl = URL(string: "https://plantcare.msgis.net/api/data/plantBoxes?plantBoxId=\(id)") else {
            fatalError()
        }
        return resourceUrl
    }
    
    func getAllForUser(withId: Identifier, completion: @escaping (Result<[DecodableModel], WebError>) -> Void){
        guard let resourceUrl = URL(string: "https://plantcare.msgis.net/api/data/plantBoxes?userId=\(withId)") else {
            fatalError()
        }
        
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
}
