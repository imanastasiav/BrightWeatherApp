//
//  TabBarViewController.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 03.06.2025.
//

import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabOne = WeatherViewController()
        tabOne.title = "Погода"
        
        let tabTwo = SettingsViewViewController()
        tabTwo.title = "Настройки"
        
        let navOne = UINavigationController(rootViewController: tabOne)
        let navTwo = UINavigationController(rootViewController: tabTwo)
        
        navOne.tabBarItem = UITabBarItem(title: "Погода", image: UIImage(systemName: "cloud.sun"), tag: 1)
        navTwo.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), tag: 2)
        
        setViewControllers([navOne, navTwo], animated: true)
    }

}
