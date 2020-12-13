//
//  SKUTableViewCell.swift
//  Goliath National Bank
//
//  Created by Juan Colilla on 13/12/20.
//

import UIKit

class SKUTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var transactionSKULabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
