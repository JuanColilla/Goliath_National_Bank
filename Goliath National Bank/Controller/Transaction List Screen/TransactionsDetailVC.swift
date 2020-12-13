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
    
    var transactions: [SKUModel] = [SKUModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        transactionsTitleLabel.text = "Transacciones con el SKU - \(transactions.first?.sku ?? "NONE")"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TransactionsDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.transactionsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TransactionTableViewCell
        
        let cellTransaction = transactions[indexPath.row]
        
        cell.transactionLabel.text = "\(cellTransaction.sku) - CURRENCY - \(cellTransaction.amount)"
        
        return cell
    }
    
    
}
