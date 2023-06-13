//
//  FeedManager.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation


protocol JSONParsable {
    func parseJSON<T: Codable>(data: Data, type: T.Type) -> T?
}

class FeedParser: JSONParsable {
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


