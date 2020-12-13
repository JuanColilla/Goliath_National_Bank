//
//  SKUListVC.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 7/12/20.
//

import UIKit

class SKUListVC: UIViewController {

    // MARK: Data Variables
    fileprivate let reuseIdentifier = "transactionCollectionCell"
    fileprivate let dataLoader = DataLoader()
    fileprivate var transactionsToShow = [Transaction]()
    
    // MARK: IBOutlets
    @IBOutlet weak var transactionsTableView: UITableView!
    
    
    @IBAction func cleanData(_ sender: UIButton) {
        CoreDataStack.sharedInstance.deleteAllData()
    }
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        loadData()
    }
    
    // MARK: Segue Data Bridge
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? TransactionsDetailVC {
            if let cell = sender as? SKUTableViewCell {
                if let indexPath = transactionsTableView.indexPath(for: cell) {
                    destinationVC.transactions = transactionsToShow[indexPath.row].transactions
                }
            }
        }
    }
    
    // MARK: Custom Functions
    
    
    fileprivate func loadData() {
        dataLoader.loadData(completion: { (transactions, source) in
            self.transactionsToShow = transactions
            DispatchQueue.main.async {
                self.transactionsTableView.reloadData()
                if source == .API {
                    self.showInfoAlert(title: "Fuente de datos", message: "Los datos se han cargado desde la API correctamente.", buttonOneText: "OK", style: .alert)
                } else {
                    self.showInfoAlert(title: "Fuente de datos", message: "No dispones de conexión a internet por lo que se han cargado los datos desde la caché.", buttonOneText: "OK", style: .alert)
                }
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
        cell.transactions = transactionsToShow[indexPath.row].transactions
        
        return cell
    }
    
}

