//
//  CategoryTableCellViewModel.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import Foundation

final class CategoryTableCellViewModel: ProductCategoryCell {
    let category: ProductCategory
    let id: Int
    let name: String
    
    // Dependency injection
    init(category: ProductCategory) {
        self.category = category
        self.id = category.id
        self.name = category.name
    }
}
