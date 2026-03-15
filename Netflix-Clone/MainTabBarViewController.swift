//
//  ViewController.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 09/01/26.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        let vc5 = UINavigationController(rootViewController: QuizIntroViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "heart")
        vc5.tabBarItem.image = UIImage(systemName: "questionmark.circle")
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Favorites"
        vc5.title = "Quiz"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        
        
    }


}

