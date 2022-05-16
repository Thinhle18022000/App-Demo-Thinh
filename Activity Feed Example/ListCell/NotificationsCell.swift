//
//  NotificationsCell.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 13/05/2022.
//

import UIKit

class NotificationsCell: UITableViewCell {

    @IBOutlet weak var lbTimestamp: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var iconStatus: UIImageView!
    @IBOutlet weak var CountUser: UILabel!
    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var heigthContent: NSLayoutConstraint!
    @IBOutlet weak var heightTimeStamp: NSLayoutConstraint!
    @IBOutlet weak var topTimestamp: NSLayoutConstraint!
    @IBOutlet weak var topContent: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImg.layer.cornerRadius = viewImg.frame.width / 2
        viewImg.layer.masksToBounds = true
        lbContent.numberOfLines = 100
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
