//
//  BloodRequests.swift
//  Copy Docket
//
//  Created by Mac on 13/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BloodRequests: UITableViewCell {

    @IBOutlet weak var bloodGroup: UILabel!
    @IBOutlet weak var usernamee: UILabel!
    @IBOutlet weak var picture: UIImageView!
    var responder:HomeScreenResponder!
    var position:Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func callClick(_ sender: Any) {
        responder.callClicked(pos: position)
    }
    @IBAction func chatClick(_ sender: Any) {
    responder.chatClicked(pos: position)
    }
}
