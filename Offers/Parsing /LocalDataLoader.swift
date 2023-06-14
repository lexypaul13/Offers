//
//  LocalDataLoader.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation



class LocalDataLoader: DataLoader {
    func loadData(from fileName: String, withExtension fileType: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("Failed to locate file: \(fileName).\(fileType)")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Failed to load data: \(error)")
            return nil
        }
    }
}
