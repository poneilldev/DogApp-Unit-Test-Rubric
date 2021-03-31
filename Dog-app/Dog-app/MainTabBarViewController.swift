//
//  MainTabBarViewController.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/29/21.
//

import UIKit

enum TabItem {
    case find, appointments
    
    var tabTitle: String {
        let title: String
        switch self {
        case .find:
            title = "Find"
        case .appointments:
            title = "Appointments"
        }
        return title
    }
    
    var index: Int {
        let tag: Int
        switch self {
        case .find:
            tag = 0
        case .appointments:
            tag = 1
        }
        return tag
    }
    
    func getIcon() -> UIImage {
        let image: UIImage
        switch self {
        case .find:
            image = UIImage(systemName: "magnifyingglass")!
        case .appointments:
            image = UIImage(systemName: "calendar")!
        }
        return image
    }
    
    var viewController: UIViewController {
        var vc: UIViewController = UIViewController()
        switch self {
        case .find:
            vc = UINavigationController(rootViewController: FindDogViewController(viewModel: FindDogViewModel()))
        case .appointments:
            vc = UINavigationController(rootViewController: AppointmentsViewController(viewModel: AppointmentsViewModel()))
        }
        return vc
    }
}

class MainTabBarViewController: UITabBarController {
    private var currentIndex = 0
    var tabItems: [TabItem] = [.find, .appointments]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tabBarcontrollers: [UIViewController] = []
        for item in tabItems {
            let vc = item.viewController
            let tabBarItem = UITabBarItem(title: item.tabTitle,
                                          image: item.getIcon(),
                                          selectedImage: item.getIcon())
            tabBarItem.tag = item.index
            vc.tabBarItem = tabBarItem
            tabBarcontrollers.append(vc)
        }
        viewControllers = tabBarcontrollers
    }

}
