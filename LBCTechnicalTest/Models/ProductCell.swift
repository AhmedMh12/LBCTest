//
//  ProductCell.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 20/01/2024.
//

import Foundation

protocol ProductCell {
    var product: Product { get }
    var id: Int { get }
    var category_id: Int { get }
    var title: String { get }
    var  description: String { get }
    var price: Double { get }
    var images_url :[String:String]? { get }
    var creation_date: String { get }
    var is_urgent: Bool { get }
    
}

