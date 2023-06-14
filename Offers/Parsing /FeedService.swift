//
//  FeedService.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

class FeedService {
    
    private let feedManager: JSONParsable
    private let dataLoader: DataLoader

    init(feedManager: JSONParsable = FeedParser(), dataLoader: DataLoader = LocalDataLoader()) {
        self.feedManager = feedManager
        self.dataLoader = dataLoader
    }
    
    func loadOffers(from file: String, withExtension fileExtension: String) -> [Offer]? {
        guard let url = Bundle.main.url(forResource: file, withExtension: fileExtension),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return feedManager.parseJSON(data: data, type: [Offer].self)
    }

}

