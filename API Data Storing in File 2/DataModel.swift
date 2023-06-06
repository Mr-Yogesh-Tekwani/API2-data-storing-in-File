//
//  DataModel.swift
//  API Data Storing in File 2
//
//  Created by Yogesh on 6/5/23.
//

import Foundation

struct Details: Codable{
    let date : String?
    let confirmed : Int?
    let deaths : Int?
    let recovered: Int?
}
