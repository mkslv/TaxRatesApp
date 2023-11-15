//
//  Rate.swift
//  Networking
//
//  Created by Max Kiselyov on 11/11/23.
//

import Foundation

struct Rate: Decodable {
    let rate: Double
    let classRate: String
    let descriptionOfTax: String
    let types: String? // Sometimes can be NULL
    let typesArray: [String]? // Sometimes I dont see it in JSON
    
    enum CodingKeys: String, CodingKey {
        case rate = "rate"
        case classRate = "class"
        case descriptionOfTax = "description"
        case types = "types"
        case typesArray = "types_array"
            
        }
}

struct TaxRates: Decodable {
    let countryCode: String
    let countryName: String
    let isEU: Bool
    let standardRate: Rate
    let otherRates: [Rate]
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case countryName = "country_name"
        case isEU = "eu"
        case standardRate = "standard_rate"
        case otherRates = "other_rates"
        
    }
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
        countries = countryPairs.map { Country(name: $0.0, code: $0.1) }
        countries.sort { $0.code < $1.code }
        
        var uniqueCodes = Set<String>()
        
        // Filter countries based on unique two-letter codes
        let filteredCountries = countries.filter {
            let isTwoLetters = $0.code.count == 2
            let isUnique = uniqueCodes.insert($0.code).inserted
            return isTwoLetters && isUnique
        }
        
        return filteredCountries
    }
}
