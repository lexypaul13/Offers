//
//  FeedService.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

enum OfferServiceError: Error {
    case failedToLoadOfferDetail
    case offerNotFound
    case failedToLoadOfferList
}

// MARK: - OfferService
class OfferService {
    
    // MARK: - Properties
    private var offers: [Offer] = []
    private let OfferService: JSONParsable & DataLoader

    // MARK: - Initialization
    init(feedManager: (JSONParsable & DataLoader) = JSONParser()) {
        self.OfferService = feedManager
    }
    
    // MARK: - Methods
    func loadOffers() -> [Offer]? {
        guard let data = OfferService.loadData(from: "Offers", withExtension: "json"),
              let parsedOffers = OfferService.parseJSON(data: data, type: [Offer].self)
        else {
            return nil
        }
        self.offers = parsedOffers
        return parsedOffers
    }

}




