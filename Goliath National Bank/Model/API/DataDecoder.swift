//
//  DataDecoder.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 11/12/20.
//

import Foundation

/// Class designated to decode a received JSON from API call.
class DataDecoder {
    
    private let decoder = JSONDecoder()
    
    /// Function designated to decode "Data" obtained from API call.
    /// - Parameters:
    ///   - typeOfData: Depending on this param (.sku or .ratio) the returned object will match the received JSON Object from the DataRetriever main function.
    ///   - dataToDecode: Data obtained from DataRetriever main function, call to the API.
    /// - Returns: It may return 3 types, if typeOfData is .sku it should return SKUModel, if .ratio should return ConversionRateModel, else will return nil.
    public func decodeDataReceived(typeOfData: requestType ,dataToDecode: Data) -> Any? {
        do {
            if typeOfData == .sku {
                let jsonDecoded = try decoder.decode(SKUModel.self, from: dataToDecode)
                return jsonDecoded
            } else {
                let jsonDecoded = try decoder.decode(ConversionRateModel.self, from: dataToDecode)
                return jsonDecoded
            }
        } catch let errorDecoding {
            print(errorDecoding.localizedDescription)
        }
        return nil
    }
  
    
}
