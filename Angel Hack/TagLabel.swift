//
//  TagLabel.swift
//  Angel Hack
//
//  Created by Jonathan Velazquez on 08/05/16.
//  Copyright © 2016 Julio Guzman. All rights reserved.
//

import UIKit
@IBDesignable
class TagLabel: UILabel {
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
    
    @IBInspectable var borderColor:UIColor = UIColor.clearColor() {
        didSet{
            config()
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0{
        didSet{
            config()
        }
    }
    
    @IBInspectable var radius:CGFloat = 0 {
        didSet{
            config()
        }
    }
    
    func config(){
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = borderWidth
        self.textAlignment = .Center
    }

}
