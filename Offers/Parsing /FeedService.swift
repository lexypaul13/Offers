//
//  FeedService.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

class FeedService {
    private var offers: [Offer] = []

    private let feedManager: JSONParsable & DataLoader

    init(feedManager: (JSONParsable & DataLoader) = FeedParser()) {
        self.feedManager = feedManager
    }
    
    func loadOffers(from file: String, withExtension fileExtension: String) -> [Offer]? {
        guard let data = feedManager.loadData(from: file, withExtension: fileExtension),
              let parsedOffers = feedManager.parseJSON(data: data, type: [Offer].self)
        else {
            return nil
        }
        self.offers = parsedOffers
        return parsedOffers
    }

}


enum FeedServiceError: Error {
    case failedToLoadOffers
}

