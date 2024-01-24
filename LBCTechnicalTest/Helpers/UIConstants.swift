//
//  UIConstants.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import Foundation
import UIKit
func sizeWithRatio( _ size: CGFloat) -> CGFloat{
    return (UIScreen.main.bounds.width / 320) * size
}

let marginSize = sizeWithRatio(10)
let paddingSize = sizeWithRatio(15)
let imageSize = sizeWithRatio(80)
let imageFullSize = UIScreen.main.bounds.width - 2 * paddingSize
let smallImageSize = sizeWithRatio(30)
let font10 = sizeWithRatio(10)
let font12 = sizeWithRatio(12)
let font20 = sizeWithRatio(20)
let font8 = sizeWithRatio(8)
let font16 = sizeWithRatio(16)
let cornerSize = sizeWithRatio(10)
let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let convertedDateFormat = "MMM d, yyyy h:mm a"
