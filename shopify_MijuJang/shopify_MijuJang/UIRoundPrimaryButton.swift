//
//  UIRoundPrimaryButton.swift
//  shopify_MijuJang
//
//  Created by Lily Jang on 2017-08-21.
//  Copyright © 2017 Lily Jang. All rights reserved.
//

import UIKit


class UIRoundPrimaryButton: UIButton {

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 10.0
        
        self.backgroundColor = UIColor( red: 100, green: 110, blue:198, alpha: 1.0 ) //UIColor.white
        
        let borderColor : UIColor = UIColor( red: 66, green: 76, blue:173, alpha: 1.0 )
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
