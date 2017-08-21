//
//  TableViewCell_OrderList.swift
//  shopify_MijuJang
//
//  Created by Lily Jang on 2017-08-21.
//  Copyright © 2017 Lily Jang. All rights reserved.
//

import UIKit

class TableViewCell_OrderList: UITableViewCell {

    @IBOutlet weak var Label_OrderId: UILabel!
    @IBOutlet weak var Label_Customer: UILabel!
    @IBOutlet weak var Label_Title: UILabel!
    @IBOutlet weak var Label_Price: UILabel!
    @IBOutlet weak var Label_CreateAt: UILabel!
    @IBOutlet weak var Label_Quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
