//
//  FeedListCollectionViewCell.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit
import SnapKit

class FeedListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OfferListCollectionViewCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let productNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.textColor = UIColor(named: "#4A4A4A")
            label.numberOfLines = 0
            label.adjustsFontForContentSizeCategory = true
            return label
        }()

        private let productAmountLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
            label.textColor = UIColor(named: "#4A4A4A")
            label.numberOfLines = 0
            return label
        }()
    
}
