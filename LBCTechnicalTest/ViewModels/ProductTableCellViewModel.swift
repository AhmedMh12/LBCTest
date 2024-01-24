//
//  ProductTableCellViewModel.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 20/01/2024.
//

import Foundation


final class ProductTableCellViewModel: ProductCell {
    let product: Product
    let id, category_id: Int
    let title, description: String
    let price: Double
    let images_url :[String:String]?
    let creation_date: String
    let is_urgent: Bool
    // Dependency injection
    init(product: Product) {
        self.product = product
        self.id = product.id
        self.category_id = product.category_id
        self.description = product.description
        self.title = product.title
        self.images_url = product.images_url
        self.price = product.price
        self.creation_date = product.creation_date
        self.is_urgent = product.is_urgent
        
    }
}

