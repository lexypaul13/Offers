//
//  OfferList.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import Foundation


typealias OfferList = [Offer]


struct Offer: Codable{
    let id: String
    let url: URL?
    let name: String
    let description: String
    let terms: String
    let currentValue: String
    
    enum CodingKeys: String, CodingKey {
           case id, url, name, description, terms
           case currentValue = "current_value"
       }
}
