//
//  SKUListVC.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 7/12/20.
//

import UIKit

class SKUListVC: UIViewController {

    // MARK: Data Variables
    fileprivate let reuseIdentifier = "transactionCell"
    fileprivate let dataLoader = DataLoader()
    fileprivate var transactionsToShow = [Transaction]()
    
    // MARK: IBOutlets
    @IBOutlet weak var transactionsTableView: UITableView!
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        loadData()
    }
    
    // MARK: Custom Functions
    
    
    fileprivate func loadData() {
        dataLoader.loadData(completion: { (transactions) in
            self.transactionsToShow = transactions
            DispatchQueue.main.async {
                self.transactionsTableView.reloadData()
            }
        })
    }


}


// MARK: TableView Delegate & Data

extension SKUListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.transactionsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SKUTableViewCell
        
        cell.transactionSKULabel.text = "SKU - \(transactionsToShow[indexPath.row].sku)"
        
        return cell
    }
    
}

