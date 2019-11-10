//
//  MainController.swift
//  HWS-Day33
//
//  Created by Steven Jemmott on 10/11/2019.
//  Copyright © 2019 Lagom Exp. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
    }
    
}

import SwiftUI

struct MainPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> UIViewController {
            let navController = UINavigationController(rootViewController: MainController())
            return navController
        }
        
        func updateUIViewController(_ uiViewController: MainPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
        }
    }
}
