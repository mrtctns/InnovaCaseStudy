//
//  NetworkManager.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    /// Decodable
    func readJSONData<T: Decodable>(fileName: String, objectType: T.Type) throws -> T {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "JSON file cannot be found", code: 0)
        }

        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
            let object = try decoder.decode(objectType, from: jsonData)
            return object
        } catch {
            throw error
        }
    }


    func fetchCurrencyData(completion: @escaping (Result<[Currency], Error>) -> Void) {
        var arrCurrency = [Currency]()

        let headers = [
            "X-RapidAPI-Key": "55b5f7c261msh7c710a5674641b8p1110ccjsn49ae7767af2b",
            "X-RapidAPI-Host": "currency-converter-pro1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://currency-converter-pro1.p.rapidapi.com/currencies")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    let data = jsonResponse!["result"] as! [String: Any]

                    for (currency, country) in data {
                        arrCurrency.append(Currency(currency: currency, country: country as! String))
                    }
                    completion(.success(arrCurrency))

                } catch {
                    print("hi")
                }
            }
        })

        dataTask.resume()
    }

    func exchangeCurrency(from: String, to: String, amount: Double, completion: @escaping (Result<Double, Error>) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "55b5f7c261msh7c710a5674641b8p1110ccjsn49ae7767af2b",
            "X-RapidAPI-Host": "currency-converter-pro1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://currency-converter-pro1.p.rapidapi.com/convert?from=\(from)&to=\(to)&amount=\(amount)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    let data = jsonResponse!["result"] as! Double

                    completion(.success(data))

                } catch {
                    print("hi")
                }
            }
        })

        dataTask.resume()
    }
}
