//
//  NetworkManager.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 06.01.2023.
//

import Foundation
import UIKit

class NetworkManager {
    let decoder = JSONDecoder()
    
    let headers = [
        "X-RapidAPI-Key": "20e6cda988mshb1ffa7966633a31p1f7f91jsne5d2a00c30e6",
        "X-RapidAPI-Host": "alpha-vantage.p.rapidapi.com"
    ]
    
    
    func getRequest(_ to: String, _ from: String, complitionHandler:@escaping (Currencys) -> Void ) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://alpha-vantage.p.rapidapi.com/query?to_currency=\(to)&function=CURRENCY_EXCHANGE_RATE&from_currency=\(from)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("Error1")
            } else {
                //let httpResponse = response as? HTTPURLResponse
                if let data = data {
                    do {
                        let jsonString1 = try self.decoder.decode(Currencys.self, from: data)
                        complitionHandler(jsonString1)
                    } catch {
                        print("Error2")
                    }
                }
            }
        })
        dataTask.resume()
    }
}
