//
//  Constants.swift
//  MVVM_Demo
//
//  Created by sai anand on 19/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import UIKit

struct Constants {
    
    // MARK: - Navigation Controller
    ///
    static var navigationController = UINavigationController()
    
    // MARK: - Screen Sizes
    /// Total Screen Size
    static let kScreenBounds: CGRect = UIScreen.main.bounds
    ///
    static let isiPhoneWidth: Bool = 320 == UIScreen.main.bounds.size.height ? true : false
    /// iPhone 4, 4s height
    static let isiPhone4: Bool = 480 == UIScreen.main.bounds.size.height ? true : false
    /// iPhone 5, 5s, 5c, SE height
    static let isiPhone5: Bool = 568 == UIScreen.main.bounds.size.height ? true : false
    /// iPhone6, 6s, 7, 8 height
    static let isiPhone6: Bool = 667 == UIScreen.main.bounds.size.height ? true : false
    /// iPhone 6+, 6s+, 7+, 8+ height
    static let isiPhone6Plus: Bool = 736 == UIScreen.main.bounds.size.height ? true : false
    /// iPhoneX height
    static let isiPhoneX: Bool = 812 == UIScreen.main.bounds.size.height ? true : false
    ///  iPhone Width
    static let deviceWidth = UIScreen.main.bounds.size.width

}
