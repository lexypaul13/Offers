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
        label.numberOfLines = 0 // To handle long text
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
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 10
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productAmountLabel)
    }
    
    func setupConstraints() {
        let margin: CGFloat = 6
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(margin)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.7) 
        }
        
        productAmountLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(margin)
            make.top.equalTo(productImageView.snp.bottom).offset(margin)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(margin)
            make.top.equalTo(productAmountLabel.snp.bottom).offset(margin)
            make.bottom.lessThanOrEqualToSuperview().inset(margin)
        }
    }

    func configure(productImage: URL?, productAmount: String?, productName: String?) {
        if let productImage {
            productImageView.loadImageUsingCache(withUrl: productImage)
        }
        
        if let productAmount {
            productAmountLabel.text = productAmount
        }
        
        if let productName{
            productNameLabel.text = productName
        }
    }
}
