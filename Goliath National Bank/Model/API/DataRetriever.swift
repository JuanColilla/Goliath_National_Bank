//
//  DataRetriever.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 8/12/20.
//

import Foundation

/// Main class for API communication. Only one asynchronous method.
class DataRetriever {
    
    private let session = URLSession.shared
    
    /// Function designated to retrieve data from server.
    /// - Parameters:
    ///   - typeOfData: Depending on what you want to download, you must specify ".sku" for transactions or ".ratio" for conversion ratios.
    ///   - completion: Data downloaded from server, unparsed JSON file.
    /// - Returns: Void, if returns from other than completionHandler will mean that this function failed at some point.
    public func getDataFromServer(typeOfData: RequestType , completion: @escaping (Data) -> ()) {
        var baseURL = "http://quiet-stone-2094.herokuapp.com"
        
        if typeOfData == .sku {
            baseURL.append("/transactions.json")
        } else {
            baseURL.append("/rates.json")
        }
        
        var request: URLRequest = URLRequest(url: URL(string: baseURL)!)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Accept" : "application/json"]
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                return
            }
            guard let data = data else {
                return
            }
            //print(String(data: data, encoding: .utf8) as Any)
            completion(data)
        }
        task.resume()
        
    }
    
}
