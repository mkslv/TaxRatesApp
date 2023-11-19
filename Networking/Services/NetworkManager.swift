//
//  Nerworking.swift
//  Networking
//
//  Created by Max Kiselyov on 11/12/23.
//

/*
 * VAT
 *
 * https://apilayer.com/marketplace/tax_data-api#authentication
 */

import Foundation

final class NetworkManager {
    
    static var shared = NetworkManager()
    private init() {}
    
    func fetchData(countryCodeISO: String, completion: @escaping (Result<TaxRates?, NetworkError>) -> Void) {
        // Опред-м URL
        let urlString = "https://api.apilayer.com/tax_data/tax_rates?country=\(countryCodeISO)"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url) // Создаем запрос
            request.httpMethod = "GET" // method type - кажется что можно не обьявлять тк GET
            request.addValue("VOrPajroI9vEe5cuyMEoOIoALGnEO1rp", forHTTPHeaderField: "apikey") // Задаем header
            
            // Create a URLSession data task
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check if there is data
                guard let data = data, error == nil else {
                    completion(.failure(.noData))
                    return
                }
                let taxes = TaxRates.getRates(for: data)
                if  taxes != nil {
                    DispatchQueue.main.async {
                        completion(.success(taxes))
                    }
                } else {
                    completion(.failure(.decodingError))
                }
            }.resume() // Resume the task to start the request
            
        } else {
            print("Invalid URL") // FIXME:
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
