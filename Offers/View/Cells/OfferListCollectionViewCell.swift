//
//  FeedListCollectionViewCell.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit
import SnapKit

class OfferListCollectionViewCell: UICollectionViewCell {
    static let identifier = "OfferListCollectionViewCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.textColor = UIColor(named: "#4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let productAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        label.textColor = UIColor(named: "#4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productAmountLabel)
    }
    
    func setupConstraints() {
        self.backgroundColor = .gray
        
        productImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(6)
            make.bottom.equalTo(productAmountLabel.snp.top).offset(-8)
        }
        
        productAmountLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.equalTo(productImageView.snp.bottom).offset(8)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.equalTo(productAmountLabel.snp.bottom).offset(3)
            make.bottom.lessThanOrEqualToSuperview().inset(6)
        }
    }

    
    func configure( productImage: URL?, productAmount: String?, productName: String?) {
        
        if let productImage {
            productImageView.loadImageUsingCache(withUrl: productImage)
        }
        
        if let productAmount {
            productAmountLabel.text = "$\(productAmount)"
        }
        
        
        if let productName{
            productNameLabel.text = productName
            
        }
    }
    
    
}
