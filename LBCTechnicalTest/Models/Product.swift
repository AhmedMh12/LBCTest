//
//  Product.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 15/01/2024.
//

import Foundation


struct Product: Codable {
    
    let id: Int
    var category_id: Int
    var title, description: String
    var price: Double
    var images_url :[String:String]?
    var creation_date: String
    var is_urgent: Bool
}
