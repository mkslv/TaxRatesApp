//
//  Rate.swift
//  Networking
//
//  Created by Max Kiselyov on 11/11/23.
//

import Foundation

struct TaxRates: Decodable {
    let countryCode: String
    let countryName: String
    let isEU: Bool?
    let standardRate: Rate
    let otherRates: [Rate]
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case countryName = "country_name"
        case isEU = "eu"
        case standardRate = "standard_rate"
        case otherRates = "other_rates"
    }
    
    static func getRates(for data: Any) -> TaxRates? {
        guard let taxRates = data as? [String : Any] else { return nil }
        
        let countryCode: String = String(describing: taxRates["country_code"] ?? "")
        let countryName: String = String(describing: taxRates["country_name"] ?? "")
        // let isEU: Bool = Bool(taxRates["eu"]) ?? false FIXME: как тут получить буул?
        
        guard var standardRateData = taxRates["standard_rate"] as? [String : Any] else { print("hui sobaki"); return nil }
        let standardRate = Rate(
            rate: (standardRateData["rate"] as? Double) ?? 0,
            classRate: String(describing: standardRateData["class"] ?? ""),
            descriptionOfTax: String(describing: standardRateData["description"] ?? ""),
            types: String(describing: standardRateData["types"] ?? nil),
            typesArray: nil
        )
        var result = TaxRates(countryCode: countryCode, countryName: countryName, isEU: nil, standardRate: standardRate, otherRates: [])
        
        guard let otherRatesData = taxRates["other_rates"] as? [[String : Any]] else { print("hui sobaki"); return result }
        var otherRates = [Rate]()
        otherRatesData.forEach { rate in
            otherRates.append(Rate(
                rate: (rate["rate"] as? Double) ?? 0,
                classRate: String(describing: rate["class"] ?? ""),
                descriptionOfTax: String(describing: rate["description"] ?? ""),
                types: String(describing: rate["types"] ?? nil),
                typesArray: (rate["types_array"] as? [String]) ?? [])
            )
        }
        return result
    }
}

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
