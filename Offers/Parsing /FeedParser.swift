//
//  FeedManager.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

class FeedParser: JSONParsable, DataLoader {
    func loadData(from fileName: String, withExtension fileType: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType),
              let data = try? Data(contentsOf: url)
        else {
            return nil
        }
        return data
    }
    
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

