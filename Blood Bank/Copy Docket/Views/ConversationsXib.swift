//
//  ConversationsXib.swift
//  Copy Docket
//
//  Created by Mac on 13/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ConversationsXib: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var userNAme: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
