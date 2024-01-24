//
//  NetworkConstants.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import Foundation

class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    public var serverAddress: String {
        get {
            return "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
        }
    }
    public var imageServerAddress: String {
        get {
            return ""
        }
    }
}
