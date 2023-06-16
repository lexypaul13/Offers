//
//  Protocols.swift
//  Offers
//
//  Created by Alex Paul on 6/14/23.
//

import Foundation

// MARK: - Protocols
protocol DataLoader {
    func loadData(from fileName: String, withExtension fileType: String) -> Data?
}

protocol OfferListCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(in cell: OfferListCollectionViewCell)
}


protocol JSONParsable {
    func parseJSON<T: Codable>(data: Data, type: T.Type) -> T?
}
