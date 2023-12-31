//
//  FeedManager.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

// MARK: - JSONParser
class JSONParser: JSONParsable, DataLoader {
    
    // MARK: - DataLoader
    func loadData(from fileName: String, withExtension fileType: String) -> Data? {
        do {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
                return nil
            }
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error loading data: \(error)")
            return nil
        }
    }
    
    // MARK: - JSONParsable
    func parseJSON<T>(data: Data, type: T.Type) -> T? where T : Decodable, T : Encodable {
        let decoder = JSONDecoder()
        do {
            let parsedData = try decoder.decode(T.self, from: data)
            return parsedData
        } catch {
            print("Failed to parse JSON: \(error)")
            return nil
        }
    }
}

