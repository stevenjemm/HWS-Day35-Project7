//
//  MainController.swift
//  HWS-Day33
//
//  Created by Steven Jemmott on 10/11/2019.
//  Copyright © 2019 Lagom Exp. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
    
    private let reuseIdentifier = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: ListViewController(infoType: .mostRecent), title: "Most Recent", imageName: ""),
            createNavController(viewController: ListViewController(infoType: .popular), title: "Popular", imageName: "")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String, systemItem: UITabBarItem.SystemItem? = nil) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)

        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
}

import SwiftUI

struct MainPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> UIViewController {
//            let navController = UINavigationController(rootViewController: MainController())
            return MainController()
        }
        
        func updateUIViewController(_ uiViewController: MainPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
        }
    }
}
