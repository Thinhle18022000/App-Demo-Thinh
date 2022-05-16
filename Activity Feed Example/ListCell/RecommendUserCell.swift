//
//  RecommendUserCell.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 12/05/2022.
//

import UIKit

class RecommendUserCell: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var lbNameUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImg.layer.cornerRadius = viewImg.frame.width / 2
        viewImg.layer.masksToBounds = true
        lbNameUser.font = UIFont(name: "Arial", size: 17)
        btnFollow.layer.cornerRadius = 10
        isChecked = false

    }
    
    @IBAction func btnChangeStatus(_ sender: Any) {
        isChecked = !isChecked
    }
    var isChecked:Bool = false{
        didSet{
            btnFollow.setTitle(isChecked ? "Unfollow" : "Follow", for: .normal)
            btnFollow.layer.backgroundColor = isChecked ? UIColor.lightGray.cgColor : UIColor.link.cgColor
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
