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
                
                // Proceso a seguir si los datos a decodificar del JSON pertenecen a la lista de transacciones:
                
                guard let jsonDecoded = try JSONSerialization.jsonObject(with: dataToDecode, options: []) as? [[String: Any]] else {
                    return nil
                }
                let jsonArray: [SKUModel] = jsonDecoded.compactMap {
                    
                    guard let sku = $0["sku"] as? String,
                          let amount = $0["amount"] as? String,
                          let currency = $0["currency"] as? String
                    else { return nil }
                    
                    let skuModel = SKUModel(context: CoreDataStack.sharedInstance.context)
                    skuModel.sku = sku
                    skuModel.amount = amount
                    skuModel.currency = currency
                    
                    return skuModel
                }
                //CoreDataStack.sharedInstance.saveContext()
                return jsonArray
                
            } else {
                
                // Proceso a seguir si los datos a decodificar del JSON pertenecen a la tabla de conversiones entre monedas:
                
                guard let jsonDecoded = try JSONSerialization.jsonObject(with: dataToDecode, options: []) as? [[String: Any]] else {
                    return nil
                }
                let jsonArray: [ConversionRateModel] = jsonDecoded.compactMap {
                    
                    guard let from = $0["from"] as? String,
                          let to = $0["to"] as? String,
                          let rate = $0["rate"] as? String
                    else { return nil }
                    
                    let conversionRateModel = ConversionRateModel(context: CoreDataStack.sharedInstance.context)
                    conversionRateModel.from = from
                    conversionRateModel.to = to
                    conversionRateModel.rate = rate
                    
                    return conversionRateModel
                }
                
                return jsonArray
            }
            
            
            
        } catch let errorDecoding {
            print(errorDecoding.localizedDescription)
        }
        return nil
    }
  
    
}
