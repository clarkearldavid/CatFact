//
//  CatModel.swift
//  CatFact
//
//  Created by Clark David on 12/12/24.
//

import Foundation

struct CatFact: Codable {
    let data: [String]
}

struct CatImage: Codable {
    var id: String = ""
    var url: String = ""
    var width: CGFloat = 0
    var height: CGFloat = 0
}
