//
//  TermsTableViewCell.swift
//  Offers
//
//  Created by Alex Paul on 6/14/23.
//

import UIKit

class TermsTableViewCell: UITableViewCell {
    
    // Identifier for the cell class
    static let identifier = "TermsTableViewCell"
    
    // MARK: - UI Components
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.textColor = UIColor(named: "4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(termsLabel)
        termsLabel.snp.makeConstraints { make in
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
        termsLabel.text = instructions
    }

}
