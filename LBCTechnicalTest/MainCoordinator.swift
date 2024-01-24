//
//  MainCoordinator.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//
import Foundation
import UIKit

protocol MainCoordinatorInterface {
    func navigateToListCategories(listCategoriesVC:ListCategoriesViewController)
    func navigateToProductDetails(product: Product)
}
struct MainCoordinator: MainCoordinatorInterface {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    func navigateToListCategories(listCategoriesVC:ListCategoriesViewController){
        navigationController?.pushViewController(listCategoriesVC, animated: true)
    }
    func navigateToProductDetails(product: Product){
        let productDetailsVC = ProductDetailsViewController(viewModel: ProductDetailsViewModel(coordinator: self))
        productDetailsVC.product = product
        navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func poptoRootVC(){
        navigationController?.popViewController(animated: true)
    }
}
