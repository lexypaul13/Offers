//
//  Enums.swift
//  Offers
//
//  Created by Alex Paul on 6/16/23.
//

import Foundation
import UIKit
enum AppFont: String {
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirNextDemiBold = "AvenirNext-DemiBold"

    func size(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

enum AppColor: String {
    case darkGray = "#4A4A4A"
    case lightGray = "#E7E7E7"
    var color: UIColor {
        switch self {
        case .darkGray:
            return UIColor(name: self.rawValue)
        case .lightGray:
            return UIColor(name: self.rawValue)
        }
    }
}

enum SystemImage: String {
    case heart = "heart"
    case heartFill = "heart.fill"
    
    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}
