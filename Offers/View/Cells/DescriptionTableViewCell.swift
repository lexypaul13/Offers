//
//  DescriptionTableViewCell.swift
//  Offers
//
//  Created by Alex Paul on 6/14/23.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    // Identifier for the cell class
    static let identifier = "DescriptionTableViewCell"
    
    // MARK: - UI Components
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Method
    func configure(with instructions: String?) {
        guard let instructions = instructions else{
            return
        }
        descriptionLabel.text = instructions
    }

}
