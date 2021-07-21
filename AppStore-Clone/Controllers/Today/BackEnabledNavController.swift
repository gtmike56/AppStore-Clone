//
//  BackEnabledNavController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-16.
//

import UIKit

class BackEnabledNavController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
    
}
