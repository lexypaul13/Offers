//
//  OfferListViewModelTests.swift
//  OffersTests
//
//  Created by Alex Paul on 6/16/23.
//

import XCTest
@testable import Offers

final class OfferListViewModelTests: XCTestCase {
    
    var sut: OfferListViewModel!
    var mockOfferService: MockOfferService!

    override func setUp() {
        super.setUp()
        let mockParser = MockJSONParser()
        mockOfferService = MockOfferService(dataParser: mockParser)
        sut = OfferListViewModel(offerService: mockOfferService)
    }
    
    override func tearDown() {
        sut = nil
        mockOfferService = nil
        super.tearDown()
    }
    
    
    func testLoadOffersSuccess() {
        sut.loadOffers { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTFail("Failed to load offers")
            }
        }
    }
    
    func testOfferCount() {
        sut.loadOffers { _ in
            XCTAssertEqual(self.sut.totalOffers, self.mockOfferService.offers.count)
        }
    }
    
    
    
    
    
    
}
