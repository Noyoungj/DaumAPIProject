//
//  MainCoordinator.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/05/23.
//

import UIKit

protocol Coordinator {
    var navigationController : UINavigationController{ get set }
    func start()
}

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController(viewModel: SearchViewModel(searchService: SearchService()))
        viewController.coordinator = self
        self.navigationController.viewControllers = [viewController]
    }
}
