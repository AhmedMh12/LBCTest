//
//  ListCategoriesViewModel.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import Foundation
import Combine

final class ListCategoriesViewModel {
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: [ProductCategory]?
    var categories: Observable<[CategoryTableCellViewModel]> = Observable(nil)
    var coordinator: MainCoordinator?
    
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
        APICaller.getLBCCategories { [weak self] result in
            self?.isLoadingData.value = false
            
            switch result {
            case .success(let categoriesData):
                self?.dataSource = categoriesData
                self?.mapCategorieData()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func mapCategorieData() {
        categories.value = self.dataSource?.compactMap({CategoryTableCellViewModel(category: $0)})
    }
    func poptoRootVC(){
        coordinator?.poptoRootVC()
    }
}
