//
//  Transaction.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//

import Foundation

/// Esta clase me permite organizar las transacciones bajo un mismo SKU
class Transaction {
    
    var sku: String = ""
    var transactions: [SKUModel] = [SKUModel]()
    
    init(sku: String, transactions: [SKUModel]) {
        self.sku = sku
        self.transactions = transactions
    }
}
