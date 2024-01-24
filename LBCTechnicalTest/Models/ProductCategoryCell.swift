//
//  ProductCategoryCell.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import Foundation

protocol ProductCategoryCell {
    var category: ProductCategory { get }
    var id: Int { get }
    var name: String { get }
}
