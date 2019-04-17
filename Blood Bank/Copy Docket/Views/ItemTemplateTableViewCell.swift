//
//  ItemTemplateTableViewCell.swift
//  Copy Docket
//
//  Created by Mac on 19/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ItemTemplateTableViewCell: UITableViewCell {

    @IBOutlet weak var links: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
