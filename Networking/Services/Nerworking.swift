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
    
    func fetchData(countryCodeISO: String) {
        // Опред-м URL
        let urlString = "https://api.apilayer.com/tax_data/tax_rates?country=\(countryCodeISO)"
        if let url = URL(string: urlString) {
            // Создаем запрос
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // header
            request.addValue("VOrPajroI9vEe5cuyMEoOIoALGnEO1rp", forHTTPHeaderField: "apikey")
            
            // Create a URLSession data task
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Check if there is data
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                // Convert the data to a string for printing
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
            }
            
            // Resume the task to start the request
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
    
}

