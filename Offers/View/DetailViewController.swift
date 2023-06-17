//
//  DetailViewController.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit
// MARK: - DetailViewController
class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    var viewModel: OfferDetailViewModel
    var isFavorite : Bool = false
    var callback :((Bool)->Void)?
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.avenirNextRegular.size(14)
        label.textColor = AppColor.gray.color
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.avenirNextDemiBold.size(18)
        label.textColor = AppColor.gray.color
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(SystemImage.heart.image, for: .normal)
        button.setImage(SystemImage.heartFill.image, for: .selected)
        button.tintColor = .red
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initializers
    init(offerID: String) {
        self.viewModel = OfferDetailViewModel(offerID: offerID)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            callback?(heartButton.isSelected)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heartButton.isSelected = isFavorite
        getOfferDetail()
        setupTableHeaderView()
        setupTableView()
        setupLabels()
        self.view.backgroundColor = .white
    }
    
    
    private func getOfferDetail(){
        viewModel.loadOffer(viewModel.offerID)
        
        
    }
    // MARK: - Setup Methods
    private func setupTableHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        
        headerView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(300)
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
        
        productNameLabel.text = viewModel.offerName
        productPriceLabel.text = viewModel.offerPrice
        
        if let offerImageUrl = viewModel.offerImage {
            productImageView.loadImageUsingCache(withUrl: offerImageUrl)
        }
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
    
    @objc private func didTapHeartButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isFavorite = sender.isSelected
        heartButton.isSelected = isFavorite
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    // MARK: - TableView Delegate & Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        headerView.backgroundColor = .lightGray
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 0, width: headerView.bounds.width - 30, height: headerView.bounds.height)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .white
        titleLabel.adjustsFontForContentSizeCategory = true
        
        titleLabel.text = section == 0 ? "Product Description." : "Product Terms."
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as! DescriptionTableViewCell
            cell.configure(with: viewModel.offerDesctiption)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TermsTableViewCell.identifier, for: indexPath) as! TermsTableViewCell
            cell.configure(with: viewModel.offerTerms)
            return cell
        }
    }
}

