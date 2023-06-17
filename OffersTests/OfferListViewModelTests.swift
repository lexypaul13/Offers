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
        sut.loadOffers()
    }
    
    override func tearDown() {
        sut = nil
        mockOfferService = nil
        super.tearDown()
    }
    
    func testOfferCount() {
        XCTAssertEqual(sut.totalOffers, mockOfferService.offers.count)
    }
    
    func testOfferId() {
        XCTAssertEqual(sut.offerId(at: 0), "offer1")
        XCTAssertEqual(sut.offerId(at: 1), "offer2")
    }


    func testOfferName() {
        XCTAssertEqual(sut.offerName(at: 0), "Offer 1")
        XCTAssertEqual(sut.offerName(at: 1), "Offer 2")
    }

    func testOfferImageURL() {
        XCTAssertEqual(sut.offerImageURL(at: 0), URL(string: "http://example.com/image1.png"))
        XCTAssertEqual(sut.offerImageURL(at: 1), URL(string: "http://example.com/image2.png"))
    }

    func testOfferAmount() {
        XCTAssertEqual(sut.offerAmount(at: 0), "10")
        XCTAssertEqual(sut.offerAmount(at: 1), "20")
    }
    
    
    func testSetIsFavorite() {
        sut.setIsFavorite(at: 0, value: false)
        XCTAssertEqual(sut.isFavorite(at: 0), false)
        
        sut.setIsFavorite(at: 1, value: true)
        XCTAssertEqual(sut.isFavorite(at: 1), true)
    }

}
