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
    weak var delegate: OfferListCollectionViewCellDelegate?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#939596")
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .red
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
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
        contentView.addSubview(containerView)
        contentView.addSubview(heartButton)
        containerView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productAmountLabel)
    }
    
    func setupConstraints() {
        let margin: CGFloat = 6
        let containerInsets: CGFloat = 6
        let imageInsets: CGFloat = 6
        let bottomMargin: CGFloat = 8
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(containerInsets)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.7)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(containerView).inset(imageInsets)
        }
        
        productAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(bottomMargin)
            make.leading.trailing.equalToSuperview().inset(margin)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(margin)
            make.top.equalTo(productAmountLabel.snp.bottom).offset(bottomMargin)
            make.bottom.lessThanOrEqualToSuperview().inset(margin)
        }
        heartButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(6)
        }
        
    }
    
    @objc private func didTapHeartButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didTapFavoriteButton(in: self)
        
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



