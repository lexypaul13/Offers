//
//  FeedListCollectionViewCell.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit
import SnapKit

class OfferListCollectionViewCell: UICollectionViewCell {
    // Identifier for the cell class
    static let identifier = "OfferListCollectionViewCell"
    
    weak var delegate: OfferListCollectionViewCellDelegate?
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(name:"#E7E7E7")
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
        label.textColor = UIColor(name: "#4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0 // To handle long text
        return label
    }()
    
    private let productAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        label.textColor = UIColor(name:"#4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
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
            make.top.trailing.equalToSuperview().inset(margin)
        }
    }
    
    // MARK: - Button Actions
    @objc private func didTapHeartButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.didTapFavoriteButton(in: self)
    }
    
    // MARK: - Configuration Method
    func configure(productImage: URL?, productAmount: String?, productName: String?, isFavourite: Bool) {
        guard let productImage else {
            return 
        }
        productImageView.loadImageUsingCache(withUrl: productImage)
        productAmountLabel.text = productAmount
        productNameLabel.text = productName
        heartButton.isSelected = isFavourite
    }
}
