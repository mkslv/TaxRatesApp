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


struct Country {
    let name: String
    let code: String
    
    static func getListOfCountries() -> [Country] {
        var countries: [Country] = [] // Initialize the array
        
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        let countryCodes = locales.compactMap { $0.region?.identifier }
        let countryNames = locales.compactMap { $0.localizedString(forRegionCode: $0.region?.identifier ?? "") }
        
        // Combine country names and codes into a dictionary
        let countryPairs = zip(countryNames, countryCodes)
        
        // Create an array of Country objects
        countries = countryPairs.map { Country(name: $0, code: $1) }
        
        return countries
    }
}
