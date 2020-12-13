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
    
    func loadData(completion: @escaping ([Transaction], SourceType) -> ()) {
        var transactions = [SKUModel]()
        
        if NetworkMonitor.sharedInstance.isConnected {
            CoreDataStack.sharedInstance.deleteAllData()
            dataRetriever.getDataFromServer(typeOfData: .sku) { (transactionsJSON) in
                transactions =  self.jsonDecoder.decodeDataReceived(typeOfData: .sku, dataToDecode: transactionsJSON) as! [SKUModel]
                CoreDataStack.sharedInstance.saveContext()
                completion(self.organizeTransactions(transactions: transactions), .API)
            }
        } else {
            transactions = CoreDataStack.sharedInstance.fetchCachedData()
            
            completion(self.organizeTransactions(transactions: transactions), .CoreData)
        }
        
    }
    
    func organizeTransactions(transactions: [SKUModel]) -> [Transaction] {
        var uniqueSKU = [String]()
        var transactionsOrganized = [Transaction]()
        
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
        
        return transactionsOrganized
    }
    
    func loadConversionRates(completion: @escaping ([ConversionRateModel]) -> ()) {
        var conversionRates = [ConversionRateModel]()
        
        dataRetriever.getDataFromServer(typeOfData: .ratio) { (conversionRateModelJSON) in
            conversionRates = self.jsonDecoder.decodeDataReceived(typeOfData: .ratio, dataToDecode: conversionRateModelJSON) as! [ConversionRateModel]
            
            completion(conversionRates)
        }
        
        
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
