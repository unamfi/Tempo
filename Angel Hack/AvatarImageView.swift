//
//  AvatarImageView.swift
//  Angel Hack
//
//  Created by Jonathan Velazquez on 07/05/16.
//  Copyright © 2016 Julio Guzman. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        config()
    }
    
    func config(){
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 3.0
    }
}