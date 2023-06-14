//
//  DetailViewController.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let tableView = UITableView()
    var viewModel: OfferDetailViewModel?
    
    init(offerID: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = OfferDetailViewModel(offerID: offerID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 17)
        label.textColor = UIColor(named: "#4A4A4A")
        
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.textColor = UIColor(named: "#4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .red
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductDetails(for: viewModel?.offerID)
        setupTableHeaderView()
        setupTableView()
        setupLabels()
        self.view.backgroundColor = .white
    }
    
    private func setupTableHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        
        headerView.addSubview(productImageView)
        
        productImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(300)
        }
        
        
        if let offerImageUrl = viewModel?.offerImage {
            productImageView.loadImageUsingCache(withUrl: offerImageUrl)
        }
        
        tableView.tableHeaderView = headerView
    }
    
    
    private func setupLabels() {
        let headerView = self.tableView.tableHeaderView
        headerView?.addSubview(productNameLabel)
        headerView?.addSubview(productPriceLabel)
        headerView?.addSubview(heartButton)
        let insetMargin = 10
        let offsetMargin = 8
        
        productNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(insetMargin)
            make.bottom.equalToSuperview().offset(insetMargin)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(insetMargin)
            make.bottom.equalTo(productNameLabel.snp.top).offset(-offsetMargin)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(insetMargin)
            make.right.equalToSuperview().offset(-insetMargin)
        }
        
        productNameLabel.text = viewModel?.offerName
        productPriceLabel.text = viewModel?.offerPrice
    }
    
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(TermsTableViewCell.self, forCellReuseIdentifier: TermsTableViewCell.identifier)
    }
    
    private func getProductDetails(for productID: String?) {
        guard let productID = productID else { return }
        viewModel?.loadOffer(productID)
    }
    
    @objc private func didTapHeartButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        headerView.backgroundColor = .lightGray
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 0, width: headerView.bounds.width - 30, height: headerView.bounds.height)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .white
        titleLabel.adjustsFontForContentSizeCategory = true
        if section == 0 {
            titleLabel.text = "Product Description."
        } else if section == 1 {
            titleLabel.text = "Product Terms."
        }
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as! DescriptionTableViewCell
            cell.configure(with: viewModel?.offerDesctiption)
            return cell
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: TermsTableViewCell.identifier, for: indexPath) as! TermsTableViewCell
            
            cell.configure(with: viewModel?.offerTerms)
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    
}
