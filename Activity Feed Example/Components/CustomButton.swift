//
//  ViewCustom.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 05/05/2022.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth  = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowOffSet: CGSize = CGSize(width: 0, height: 0){
        didSet{
            self.layer.shadowOffset = shadowOffSet
        }
    }
    
    @IBInspectable var shadowQpacity: Float = 0{
        didSet{
            self.layer.shadowOpacity = shadowQpacity
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black{
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0{
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var maskTobounds: Bool = false{
        didSet{
            self.layer.masksToBounds = maskTobounds
        }
    }
}
