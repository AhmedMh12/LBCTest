//
//  ProductDetailsViewModel.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 24/01/2024.
//

import Foundation

final class ProductDetailsViewModel {
    var coordinator: MainCoordinator?
    init(coordinator: MainCoordinator) {
           self.coordinator = coordinator
       }
    
    func poptoRootVC(){
        coordinator?.poptoRootVC()
    }
}
