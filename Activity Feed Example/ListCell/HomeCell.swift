//
//  HomeCell.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 10/05/2022.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var timeActive: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var avatar: UIButton!
    @IBOutlet weak var captions: UILabel!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var hightImg: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customImage()
        likeCount.font = UIFont(name: "Arial", size: 13)
    }
    @IBAction func btnHeart(_ sender: UIButton) {
        isChecked = !isChecked
    }
    
    var isChecked: Bool = false{
        didSet{
            btnHeart.setImage(UIImage(named: isChecked ? "heart-outline" : "heart"), for: .normal)
            likeCount.text = isChecked ? "0 like" : "1 like"
         }
    }
    
    func customImage(){
        imgAvatar.layer.cornerRadius = imgAvatar.frame.width / 2
        imgAvatar.layer.masksToBounds = true
        imgAvatar.contentMode = .scaleAspectFill
        imgContent.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
