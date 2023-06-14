//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Eduardo Pino on 14-06-23.
//

import Foundation
struct JSONMenu: Codable {
    let menu: [MenuItem]
}


struct MenuItem: Codable {
    let id: Int32
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
} 
