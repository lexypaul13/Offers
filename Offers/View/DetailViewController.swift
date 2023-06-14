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
    
    private let dimImageView:UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    //UIColor(named: "#f4f5f7")
    
    private let headerView:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.textColor = UIColor(named: "#4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        label.textColor = UIColor(named: "#4A4A4A")
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductDetails(for: viewModel?.offerID)
        setupHeaderView()
        setupTableView()
        self.view.backgroundColor = .white
    }
    
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.addSubview(productImageView)
        headerView.addSubview(dimImageView)
        headerView.addSubview(productNameLabel)
        headerView.addSubview(productPriceLabel)
        headerView.addSubview(heartButton)

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(450)
        }

        productImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }

        heartButton.snp.makeConstraints { make in
             make.top.equalToSuperview().inset(20)
             make.right.equalToSuperview().inset(20)
         }


        dimImageView.snp.makeConstraints { make in
            make.edges.equalTo(productImageView)
        }

        productPriceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-5)
        }

        productNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.bottom.equalTo(productPriceLabel.snp.top).offset(-5)
        }

        if let offerImageUrl = viewModel?.offerImage {
            productImageView.loadImageUsingCache(withUrl: offerImageUrl)
        }

        productNameLabel.text = viewModel?.offerName
        productPriceLabel.text = viewModel?.offerPrice
    }


    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(TermsTableViewCell.self, forCellReuseIdentifier: TermsTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    
    private func getProductDetails(for productID: String?) {
        guard let productID = productID else { return }
        viewModel?.loadOffer(productID)
    }


    @objc private func didTapHeartButton() {
        // Add your desired action here
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
