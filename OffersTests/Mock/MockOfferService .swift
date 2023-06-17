//
//  MockOfferService .swift
//  OffersTests
//
//  Created by Alex Paul on 6/16/23.
//

import Foundation
@testable import Offers

class MockOfferService: OfferService {
    
    init(dataParser: (JSONParsable & DataLoader)) {
        super.init(fileName: "MockOffer", fileExtension: "json", dataParser: dataParser)
    }
    
    override func loadOffers() -> [Offer]? {
        return super.loadOffers()
    }
}
