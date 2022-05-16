//
//  ProfileVC.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 28/04/2022.
//

import UIKit

class ProfileVC: BaseVC {
    
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnAvatarProfile: UIButton!
    @IBOutlet weak var btnAvatarTimestamp: UIView!
    @IBOutlet weak var lbFollowing: UILabel!
    @IBOutlet weak var lbFollower: UILabel!
    @IBOutlet weak var lbTimestamp: UILabel!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewImgTimestamp: UIView!
    @IBOutlet weak var imgTimestamp: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    var reports:[RepostsMD] = []
    var likes:[LikesMD] = []
    var comment:[CommentsMD] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataReport()
        getDataFollowing()
        customLayout()
        getDataFollower()
    }
    
    @IBAction func btnBackHome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func customLayout(){
        btnAvatarProfile.layer.cornerRadius = btnAvatarProfile.frame.width / 2
        btnAvatarProfile.layer.masksToBounds = true
        btnAvatarTimestamp.layer.cornerRadius = btnAvatarTimestamp.frame.width / 2
        btnAvatarTimestamp.layer.masksToBounds = true
        viewImage.layer.cornerRadius = viewImage.frame.width / 2
        viewImage.layer.masksToBounds = true
        imgProfile.contentMode = .scaleAspectFill
        viewImgTimestamp.layer.cornerRadius = viewImgTimestamp.frame.width / 2
        viewImgTimestamp.layer.masksToBounds = true
        imgTimestamp.contentMode = .scaleAspectFill
    }
    
    func getDataFollower(){
        CommentsAPI().getComments { [weak self] (result) in
            switch result{
                case .success(let comments):
                    self?.comment = comments
                    self?.profitle()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func getDataFollowing(){
        LikeAPI().getDataLike { [weak self] (result) in
            switch result{
                case .success(let like):
                    self?.likes = like
                    self?.profitle()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func getDataReport(){
        ReportAPI().getReports { [weak self] (result) in
            switch result{
                case .success(let report):
                    self?.reports = report
                    self?.profitle()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func profitle(){
        if let report = reports.first(where: {$0.author?.avatar != nil}){
            BaseAPI.shard.downloadImage(url: report.author?.avatar ?? "") { (img) in
                if let img = img{
                    self.imgProfile.image = img
                    self.imgTimestamp.image = img
                    self.lbFollower.text = String(self.comment.count)
                    self.lbFollowing.text = String(self.likes.count)
                } else {
                    self.imgProfile.image = nil
                    self.imgTimestamp.image = nil
                    self.lbFollower.text = nil
                    self.lbFollowing.text = nil
                }
                return
            }
        }
    }
}
