//
//  Rate.swift
//  Networking
//
//  Created by Max Kiselyov on 11/11/23.
//

import Foundation

struct Rate {
    let rate: Double
    let classRate: String
    let description: String
    let types: String? // Sometimes can be NULL
    let typesArray: [String]? // Sometimes I dont see it in JSON
}

struct TaxRates {
    let countryCode: String
    let countryName: String
    let standardRate: Rate
    let otherRates: [Rate]
}
