//
//  MockJSONParser.swift
//  OffersTests
//
//  Created by Alex Paul on 6/16/23.
//

import Foundation
@testable import Offers

class MockJSONParser: JSONParsable & DataLoader {
    var shouldReturnLoadError = false
    var shouldReturnParseError = false

    func loadData(from fileName: String, withExtension fileType: String) -> Data? {
        if shouldReturnLoadError {
            return nil
        }

        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: fileType),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Failed to locate JSON file ")
            return nil
        }
        return data
    }



    func parseJSON<T>(data: Data, type: T.Type) -> T? where T : Decodable, T : Encodable {
        if shouldReturnParseError {
            return nil
        }
        
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
