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
    fileprivate var transactionsToShow = [Transaction]()
    fileprivate var currencyConversor: CurrencyConversor?
    
    // MARK: IBOutlets
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var dataSourceIndicator: UIImageView!
    @IBOutlet var blackBackground: UIView!
    @IBOutlet var welcomeView: UIView! {
        didSet {
            welcomeView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var setNameButton: UIButton! {
        didSet {
            setNameButton.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeText: UITextView! {
        didSet {
            welcomeText.text = L10n.welcomeText.localized()
        }
    }
    
    
    @IBAction func setNameButton(_ sender: UIButton) {
        if !(nameLabel.text?.isEmpty ?? false) {
            UserDefaults.standard.setValue(nameLabel.text, forKey: "UserName")
            UserDefaults.standard.setValue(true, forKey: "NameAsked")
            let hideWelcomeViewanimation = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                self.welcomeView.alpha = 0
                self.blackBackground.removeFromSuperview()
                self.welcomeView.removeFromSuperview()
            }
            hideWelcomeViewanimation.startAnimation()
            welcomeLabel.text = L10n.welcomeMessage(UserDefaults.standard.string(forKey: "UserName") ?? "").localized()
        } else {
            self.showInfoAlert(title: L10n.invalidNameTitle.localized(), message: L10n.invalidNameMessage.localized(), buttonOneText: L10n.ok.localized(), style: .alert)
        }
        
    }
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Dado que la primera vez que se abra la app no habrá datos cacheados, entretengo un par de segundos al usuario con algo que me ofrezca ese segundo o dos que se tarda en descargar, organizar y mostrar las más de 5.000 entradas que la API proporciona (según la calidad de la conexión de red). Ofrezco además una experiencia personalizada al recordar su nombre de ahora en adelante.
        
        // Se ha comentado porque el "viewContext" entraba en conflicto con la carga de datos de CoreData.
        
        if !UserDefaults.standard.bool(forKey: "NameAsked") {
            self.view.addSubview(blackBackground)
            self.view.addSubview(welcomeView)
            blackBackground.center.x = self.view.center.x
            blackBackground.center.y = self.view.center.y
            welcomeView.center.x = self.view.center.x
            welcomeView.center.y = self.view.center.y
            welcomeView.alpha = 0
            blackBackground.alpha = 0

            let showWelcomeViewanimation = UIViewPropertyAnimator(duration: 1.5, curve: .linear) {
                self.welcomeView.alpha = 1
                self.blackBackground.alpha = 0.5
            }
            showWelcomeViewanimation.startAnimation()
        } else {
            welcomeLabel.text = L10n.welcomeMessage(UserDefaults.standard.string(forKey: "UserName") ?? "").localized()
        }
        

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
        DataLoader.sharedInstance.loadData(completion: { (transactions, source) in
            self.transactionsToShow = transactions
            DispatchQueue.main.async {
                self.transactionsTableView.reloadData()
                if source == .API {
                    self.dataSourceIndicator.image = UIImage(systemName: "checkmark.icloud.fill")
                    self.dataSourceIndicator.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    self.dataSourceIndicator.image = UIImage(systemName: "xmark.icloud.fill")
                    self.dataSourceIndicator.tintColor = #colorLiteral(red: 1, green: 0.8293940282, blue: 0, alpha: 1)
                    self.showInfoAlert(title: L10n.dataSourceAlertTitle.localized(), message: L10n.internetUnavailableMessage.localized(), buttonOneText: L10n.ok.localized(), style: .alert)
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

