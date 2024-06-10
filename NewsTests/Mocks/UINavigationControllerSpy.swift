//
//  UINavigationControllerSpy.swift
//  NewsTests
//
//  Created by Malengo on 10/06/24.
//

import UIKit

class UINavigationControllerSpy: UINavigationController {
    
    var pushViewControllerHandler: ((_ viewController: UIViewController, _ animeted: Bool) -> Void)?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerHandler?(viewController, animated)
    }
}
