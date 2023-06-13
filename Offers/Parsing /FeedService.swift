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
    
    func loadOffers(from fileName: String, withExtension fileType: String) -> OfferList? {
        guard let data = dataLoader.loadData(from: fileName, withExtension: fileType) else {
            return nil
        }
        return feedManager.parseJSON(data: data, type: OfferList.self)
    }
}

