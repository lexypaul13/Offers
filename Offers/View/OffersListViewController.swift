//
//  OffersListViewController.swift
//
//  Created by Alex Paul on 6/12/23.
//

import UIKit

class OffersListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
 
    private let viewModel = OfferListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Offer List"
        view.backgroundColor = .gray
        setUpCollectionView()
        getOfferList()
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OfferListCollectionViewCell.self, forCellWithReuseIdentifier: OfferListCollectionViewCell.identifier)

        // Configure layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    
    private func getOfferList(){
        viewModel.loadOffers()
    }

}

extension OffersListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.totalOffers
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferListCollectionViewCell.identifier, for: indexPath) as? OfferListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let productName =  viewModel.offerName(at: indexPath.row)
        let productImage = viewModel.offerImageURL(at: indexPath.row)
        let productAmount = viewModel.offerAmount(at: indexPath.row)

        cell.configure(productImage: productImage, productAmount: productAmount, productName: productName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let offerID = viewModel.offerId(at: indexPath.item) else{
            return
        }
        let detailViewController = DetailViewController(offerID: offerID)

        detailViewController.viewModel = OfferDetailViewModel(offerID: offerID)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:100)
    }

    
    
}

