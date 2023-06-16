//
//  FeedService.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

enum OfferServiceError: Error {
    case failedToLoadOffers
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
    func loadOffers(from file: String, withExtension fileExtension: String) -> [Offer]? {
        guard let data = OfferService.loadData(from: file, withExtension: fileExtension),
              let parsedOffers = OfferService.parseJSON(data: data, type: [Offer].self)
        else {
            return nil
        }
        self.offers = parsedOffers
        return parsedOffers
    }

}




