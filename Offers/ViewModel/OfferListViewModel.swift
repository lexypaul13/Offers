//
//  OfferListViewModel.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

class OfferListViewModel {
    private let feedService: FeedService
    private var offers: [Offer] = []
    
    init(feedService: FeedService = FeedService()) {
        self.feedService = feedService
    }
    
    var totalOffers: Int {
        return offers.count
    }
    
    func offerId(at index: Int) -> String? {
        return validIndex(index) ? offers[index].id : nil
    }
    
    func isFavorite(at index: Int) -> Bool {
        return validIndex(index) ? offers[index].favorite : false
    }
    
    func setIsFavorite(at index: Int, value: Bool) {
        if validIndex(index) {
            offers[index].favorite = value
        }
    }
    
    func offerName(at index: Int) -> String? {
        return validIndex(index) ? offers[index].name : nil
    }
    
    func offerImageURL(at index: Int) -> URL? {
        return validIndex(index) ? offers[index].url : nil
    }
    
    func offerAmount(at index: Int) -> String? {
        return validIndex(index) ? offers[index].currentValue : nil
    }
    
    func toggleFavorite(at index: Int) {
        if validIndex(index) {
            offers[index].favorite.toggle()
        }
    }
    
    func loadOffers(completion: @escaping (Result<Void, Error>) -> Void) {
        if let offerList = feedService.loadOffers(from: "Offers", withExtension: "json") {
            self.offers = offerList
            completion(.success(()))
        } else {
            completion(.failure(FeedServiceError.failedToLoadOffers))
        }
    }

    private func validIndex(_ index: Int) -> Bool {
        return index >= 0 && index < totalOffers
    }
}
