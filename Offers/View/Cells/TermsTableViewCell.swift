//
//  TermsTableViewCell.swift
//  Offers
//
//  Created by Alex Paul on 6/14/23.
//

import UIKit

class TermsTableViewCell: UITableViewCell {

    static let identifier = "TermsTableViewCell"
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    
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
    
    func configure(with instructions: String?) {
        guard let instructions = instructions else{
            return
        }
        termsLabel.text = instructions
    }

}
