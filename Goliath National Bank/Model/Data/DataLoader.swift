//
//  DataLoader.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 12/12/20.
//

import Foundation

class DataLoader {
    
    private let dataRetriever = DataRetriever()
    private let jsonDecoder = DataDecoder()
    
    func loadData(completion: @escaping ([Transaction]) -> ()) {
        var transactions = [SKUModel]()
        var transactionsOrganized = [Transaction]()
        
        dataRetriever.getDataFromServer(typeOfData: .sku) { (json) in
            transactions =  self.jsonDecoder.decodeDataReceived(typeOfData: .sku, dataToDecode: json) as! [SKUModel]
            
            var uniqueSKU = [String]()
            
            for transaction in transactions {
                if !uniqueSKU.contains(transaction.sku) {
                    uniqueSKU.append(transaction.sku)
                }
            }
            
            print(String(describing: uniqueSKU))
            
            for sku in uniqueSKU {
                transactionsOrganized.append(Transaction(sku: sku, transactions: [SKUModel]()))
            }
            
            print(String(describing: transactionsOrganized))
            
            for position in transactionsOrganized {
                for transaction in transactions {
                    if transaction.sku == position.sku {
                        position.transactions.append(transaction)
                    }
                }
            }
            
            print(String(describing: transactionsOrganized))
            
            completion(transactionsOrganized)
        }
        
        // if first time
        //  load data from server
        // else
        //  load data from database
        //  update database data
        
        // Lógica para organizar todas las transacciones en base a si comparten un SKU o no:
        
        // --------------------------------------------------------------------------------------
        //  for model in dataToShow
        //   if element.sku == string
        //    model.append(element)
        //   else
        //    datatoshow.append(element.sku : element)
    }
    
    
}

class Transaction {
    var sku: String = ""
    var transactions: [SKUModel] = [SKUModel]()
    
    init(sku: String, transactions: [SKUModel]) {
        self.sku = sku
        self.transactions = transactions
    }
}
