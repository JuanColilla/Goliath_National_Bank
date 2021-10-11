//
//  TransactionsDetailVC.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//

import UIKit

class TransactionsDetailVC: UIViewController {
    
    fileprivate let reuseIdentifier = "transactionCell"
    
    @IBOutlet weak var transactionsTitleLabel: UILabel!
    @IBOutlet weak var transactionsTableView: UITableView!
    
    @IBOutlet weak var transactionsAmountSumLabel: UILabel!
    @IBOutlet weak var totalEURAmountLabel: UILabel!
    @IBOutlet weak var totalUSDAmountLabel: UILabel!
    @IBOutlet weak var totalCADAmountLabel: UILabel!
    @IBOutlet weak var totalAUDAmountLabel: UILabel!
    
    // La idea era que pulsar este botón cambiase la moneda de todas las transacciones de la lista.
    @IBAction func changeCurrencyButton(_ sender: UIButton) {
    }
    
    
    var transactions: [SKUModel] = [SKUModel]()
    var currencyConversor = CurrencyConversor()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        transactionsTitleLabel.text = L10n.transactionsWithSKU(transactions.first?.sku ?? "NONE").localized()
        
        loadData()
    }
    
    
    func loadData() {
    }

}


extension TransactionsDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.transactionsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TransactionTableViewCell
        
        let cellTransaction = transactions[indexPath.row]
        
        cell.transactionLabel.text = "\(cellTransaction.sku) - \(cellTransaction.currency) - \(cellTransaction.amount)"
        
        return cell
    }
    
    
}
