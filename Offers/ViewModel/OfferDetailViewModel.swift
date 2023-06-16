//
//  OfferDetailListViewModel.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation

// MARK: - OfferDetailViewModel
class OfferDetailViewModel{
    
    // MARK: - Properties
    private let offerService: OfferService
    private var offerDetail: Offer?
     let offerID: String

    
    // MARK: - Initialization
    init(offerID: String, offerService: OfferService = OfferService()) {
         self.offerService = offerService
         self.offerID = offerID
     }
    
    
    // MARK: - Computed Properties
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
    
    var offerImage: URL?{
        return offerDetail?.url
    }
    
    
    // MARK: - Public Methods
    func loadOffer(_ withID: String, completion: @escaping (Result<Offer?, Error>) -> Void) {
        guard let offerList = offerService.loadOffers(from: "Offers", withExtension: "json") else {
            let error = OfferServiceError.failedToLoadOffers
            print("Failed to load offers: \(error)")
            completion(.failure(error))
            return
        }
        
        self.offerDetail = offerList.first(where: {$0.id == withID})
        completion(.success(self.offerDetail))
    }

    
    
    
}
