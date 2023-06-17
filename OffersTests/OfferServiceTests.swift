//
//  OfferServiceTests.swift
//  OffersTests
//
//  Created by Alex Paul on 6/16/23.
//

import XCTest
@testable import Offers

final class OfferServiceTests: XCTestCase {
    
    var offerService: OfferService!
    var mockJSONParser: MockJSONParser!

    override func setUp() {
        super.setUp()
            mockJSONParser = MockJSONParser()
            offerService = MockOfferService(dataParser: mockJSONParser)
    }

    override func tearDown() {
        offerService = nil
        mockJSONParser = nil
        super.tearDown()
    }

    func testLoadOffersReturnsOffersWhenJSONParsingSucceeds() {
        mockJSONParser.shouldReturnLoadError = false

        let offers = offerService.loadOffers()

        XCTAssertNotNil(offers, "OfferService should return offers when JSON parsing succeeds")
    }

    func testLoadOffersReturnsNilWhenJSONParsingFails() {
        mockJSONParser.shouldReturnLoadError = true

        let offers = offerService.loadOffers()

        XCTAssertNil(offers, "OfferService should return nil when JSON parsing fails")
    }

}

