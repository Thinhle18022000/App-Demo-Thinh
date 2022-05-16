//
//  InteterstingUserCell.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 11/05/2022.
//

import UIKit

class InteterstingUserCell: UICollectionViewCell {
    @IBOutlet weak var ViewImg: UIView!{
        didSet{
            ViewImg.layer.cornerRadius = ViewImg.frame.width / 2
            ViewImg.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var ImgUser: UIImageView!{
        didSet{
            ImgUser.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var btnUser: UIButton!
}
