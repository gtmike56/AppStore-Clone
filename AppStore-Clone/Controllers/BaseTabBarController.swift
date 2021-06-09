//
//  ViewController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        viewControllers = [
            createNavController(vC: TodayViewController(), barImageName: "today_icon", title: "Today"),
            createNavController(vC: AppsPageViewController(), barImageName: "apps", title: "Apps"),
            createNavController(vC: SearchViewController(), barImageName: "search", title: "Search")
        ]
    }

    fileprivate func createNavController(vC: UIViewController, barImageName: String, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vC)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.image = UIImage(named: barImageName)
        navController.tabBarItem.title = title
        return navController
    }

}

