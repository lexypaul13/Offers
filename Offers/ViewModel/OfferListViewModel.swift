//
//  OfferListViewModel.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

class OfferListViewModel{
    private let feedService: FeedService
    private var offers: [Offer] = []
    
    init(feedService: FeedService = FeedService()) {
        self.feedService = feedService
    }
    
    var totalOffers:Int{
        return offers.count
    }
    
    func offerId(at index: Int) -> String? {
        guard index >= 0 && index < totalOffers else { return nil }
        return offers[index].id
    }
    
    func offerName(at index: Int) -> String? {
        guard index >= 0 && index < totalOffers else { return nil }
        return offers[index].name
    }
    
    func offerImageURL(at index: Int) -> URL? {
        guard index >= 0 && index < totalOffers else { return nil }
        return offers[index].url
    }
    
    func offerAmount(at index: Int) -> String? {
        guard index >= 0 && index < totalOffers else { return nil }
        return offers[index].currentValue
    }
    
    func isOfferFavorited(at index: Int) -> Bool {
        guard index >= 0 && index < totalOffers else { return false }
        return offers[index].favorite
    }
    
    func toggleFavorite(at index: Int) {
        guard index >= 0 && index < totalOffers else { return }
        offers[index].favorite.toggle()
    }
    
    func loadOffers() {
        guard let offerList = feedService.loadOffers(from: "Offers", withExtension: "json") else {
            print("Failed to load offers")
            return
        }
        self.offers = offerList
    }
}

