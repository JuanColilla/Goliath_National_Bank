//
//  TransactionTableViewCell.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var transactionLabel: UILabel!
    
    //var sku: SKUModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
