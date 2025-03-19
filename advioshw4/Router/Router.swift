//
//  Router.swift
//  advioshw4
//
//  Created by Dias Jakupov on 19.03.2025.
//

import UIKit
import SwiftUI

class AppRouter: NSObject {
    static var shared: AppRouter?
    
    let navigationController: UINavigationController
    
    override init() {
        let heroListViewModel = HeroListViewModel()
        let heroListView = HeroListView(viewModel: heroListViewModel)
        let hostingController = UIHostingController(rootView: heroListView)
        hostingController.title = "Heroes"
        
        navigationController = UINavigationController(rootViewController: hostingController)
        super.init()
        
        hostingController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Favorites",
            style: .plain,
            target: self,
            action: #selector(showFavorites)
        )
    }
    
    @objc func showFavorites() {
        pushFavoritesView()
    }
    
    func pushHeroDetailView(with hero: Hero) {
        let detailViewModel = HeroDetailViewModel()
        detailViewModel.hero = hero
        let detailView = HeroDetailView(viewModel: detailViewModel)
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.title = hero.name
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func pushFavoritesView() {
        let favoritesViewModel = FavoritesViewModel()
        let favoritesView = FavoritesView(viewModel: favoritesViewModel)
        let hostingController = UIHostingController(rootView: favoritesView)
        hostingController.title = "Favorites"
        navigationController.pushViewController(hostingController, animated: true)
    }
    
    func getRootViewController() -> UIViewController {
        return navigationController
    }
}
