//
//  OfferService.swift
//  Offers
//
//  Created by Alex Paul on 6/16/23.
//

import Foundation

// MARK: - OfferService
class OfferService {
    
    // MARK: - Properties
    var offers: [Offer] = []
    let dataParser: (JSONParsable & DataLoader)
    var fileName: String
    var fileExtension: String
    
    // MARK: - Initialization
    init(fileName: String = "Offers", fileExtension: String = "json", dataParser: (JSONParsable & DataLoader) = JSONParser()) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.dataParser = dataParser
    }
    
    // MARK: - Methods
    func loadOffers() -> [Offer]? {
        guard let data = dataParser.loadData(from: fileName, withExtension: fileExtension),
              let parsedOffers = dataParser.parseJSON(data: data, type: [Offer].self)
        else {
            return nil
        }
        self.offers = parsedOffers
        return parsedOffers
    }
}


