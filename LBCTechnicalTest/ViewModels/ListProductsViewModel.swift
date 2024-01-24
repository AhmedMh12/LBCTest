//
//  ListProductsViewModel.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 20/01/2024.
//

import Foundation
import Combine

final class ListProductsViewModel {
    var coordinator: MainCoordinator?
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: [Product]?
    var categories: [ProductCategory]?
    var products: Observable<[ProductTableCellViewModel]> = Observable(nil)
    
    init(coordinator: MainCoordinator) {
           self.coordinator = coordinator
       }
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func getData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        APICaller.getLBCProducts { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let productsData):
                self?.getCategories(productsData: productsData)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    
    func getCategories(productsData: [Product]){
        APICaller.getLBCCategories { [weak self] result in
            switch result {
            case .success(let categoriesData):
                self?.categories = categoriesData
                self?.dataSource = self?.sortProductByDate(products:productsData)
                self?.mapProductData()
            case .failure(let err):
                print(err)
            }
        }
    }
    func mapProductData() {
        products.value = self.dataSource?.compactMap({ProductTableCellViewModel(product: $0)})
    }
    
    func getProductTitle(_ product: Product) -> String {
        return product.title
    }
    
    func retriveProduct(withId id: Int) -> Product? {
        guard let product = dataSource?.first(where: {$0.id == id}) else {
            return nil
        }
        
        return product
    }
    func getProductsWithCategory(withId id: Int) -> [Product]? {
        let filteredProducts = dataSource?.filter { $0.category_id == id }
        return filteredProducts
    }
    func retriveCategoryName(withId idCategory: Int) -> String? {
        guard let productCategory = categories?.first(where: {$0.id == idCategory}) else {
            return nil
        }
        return productCategory.name
    }
    func openFilterVC(listCategoriesVC:ListCategoriesViewController) {
        coordinator?.navigateToListCategories(listCategoriesVC: listCategoriesVC)
    }
    func openProductDetails(product: Product){
        coordinator?.navigateToProductDetails(product: product)
    }
    func sortProductByDate(products: [Product])-> [Product] {
        
        let sortedProducts = products.sorted { (product1, product2) -> Bool in
            // Sort by urgency first (urgent products come first)
            if product1.is_urgent && !product2.is_urgent {
                return true
            } else if !product1.is_urgent && product2.is_urgent {
                return false
            }
            
            // If urgency is the same, sort by creation date in descending order
            guard let date1 = DateFormatter.iso8601Full.date(from: product1.creation_date), let date2 = DateFormatter.iso8601Full.date(from: product2.creation_date) else {
                return false // Handle the case where date conversion fails
            }
            
            return date1 > date2
        }
        return sortedProducts
    }
    
    func convertDateString(_ dateString: String, fromFormat: String, toFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = toFormat
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        }

        return nil
    }
}
