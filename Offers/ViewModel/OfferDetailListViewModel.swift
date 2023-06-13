//
//  OfferDetailListViewModel.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

class OfferDetailViewModel{
    
    private let feedService: FeedService
    private var offerDetail: Offer?
    
    init(feedService: FeedService = FeedService()) {
        self.feedService = feedService
    }
    
    
    var offerName:String{
        return offerDetail?.name ?? "No Name Available"
    }
    var offerPrice:String{
        return offerDetail?.currentValue ?? "No Price Available"
    }
    var offerDesctiption: String{
        return offerDetail?.description ?? "No Details Available"
    }
    
    var offerTerms: String{
        return offerDetail?.terms ?? "No Terms Available"
    }
}
