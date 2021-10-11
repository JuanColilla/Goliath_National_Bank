//
//  DataLoader.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 12/12/20.
//

import Foundation

/// Loader class, its purpose is to provide the requested data either from the API or Cached Storage if Internet Connectivity isn't available.
class DataLoader {
    
    private let dataRetriever = DataRetriever()
    private let jsonDecoder = DataDecoder()
    
    static let sharedInstance = DataLoader()
    
    private init() {}
    
    /// Load Transactions from where they are available.
    /// - Parameter completion: Transactions retrieved from API or CoreData and it's source.
    /// - Returns: Completion
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
            transactions = CoreDataStack.sharedInstance.fetchCachedTransactionsData()
            completion(self.organizeTransactions(transactions: transactions), .CoreData)
        }
        
    }
    
    /// Organize Transactions based on the same SKU, avoiding +5.000 cells on the TableView (even using reusableCells)
    /// - Parameter transactions: All downloaded or stored Transactions
    /// - Returns: Organized Transactions vía "key - value" (SKU - Transactions)
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
    
    /// Download or fetch Conversion Rates.
    /// - Parameter completion: Conversion Rates found.
    /// - Returns: Completion
    func loadConversionRates(completion: @escaping ([ConversionRateModel]) -> ()) {
        var conversionRates = [ConversionRateModel]()
        
        if NetworkMonitor.sharedInstance.isConnected {
            dataRetriever.getDataFromServer(typeOfData: .ratio) { (conversionRateModelJSON) in
                conversionRates = self.jsonDecoder.decodeDataReceived(typeOfData: .ratio, dataToDecode: conversionRateModelJSON) as! [ConversionRateModel]
                CoreDataStack.sharedInstance.saveContext()
                completion(conversionRates)
            }
        } else {
            conversionRates = CoreDataStack.sharedInstance.fetchCachedRatiosData()
            
            completion(conversionRates)
        }
    }
    
    
}
