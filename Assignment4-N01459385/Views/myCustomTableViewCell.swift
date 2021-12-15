//
//  myCustomTableViewCell.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-14.
//

import UIKit

class myCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var itemRank: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemYear: UILabel!
    
    @IBOutlet weak var itemImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
