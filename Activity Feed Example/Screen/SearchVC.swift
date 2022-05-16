//
//  SearchVC.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 28/04/2022.
//

import UIKit

class SearchVC: BaseVC {
    
    @IBOutlet weak var tbvRecommendUser: UITableView!
    @IBOutlet weak var clTrendingGroup: UICollectionView!
    @IBOutlet weak var clUserInteresting: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.setIcon(#imageLiteral(resourceName: "search"))
        }
    }
    var notifications:[NotificationsMD] = []
    var comments:[CommentsMD] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        colletionView()
        tableView()
    }
    
    func tableView(){
        self.tbvRecommendUser.delegate = self
        self.tbvRecommendUser.dataSource = self
        getDataRecommentUser()
    }
    
    func colletionView(){
        self.clUserInteresting.delegate = self
        self.clUserInteresting.dataSource = self
        getDataUserInteresting()
        self.clTrendingGroup.delegate = self
        self.clTrendingGroup.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: notifications.count, section: 0)
        self.clUserInteresting.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
    }
    
    func getDataRecommentUser(){
        CommentsAPI().getComments { [weak self] result in
            switch result{
                case .success(let comment):
                    self?.comments = comment
                    self?.tbvRecommendUser.reloadData()
            case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    func getDataUserInteresting(){
        NotificationAPI().getNotification { [weak self] (resultNotfi) in
            switch resultNotfi{
                case .success(let notifi):
                    self?.notifications = notifi
                    self?.clUserInteresting.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.clUserInteresting{
            return notifications.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == self.clUserInteresting else {
            let cell = clTrendingGroup.dequeueReusableCell(withReuseIdentifier: "grouptrendingcell", for: indexPath) as! TrendingGroupCell
            cell.btnImg.setImage(UIImage(named: "beer"), for: .normal)
            cell.btnBonus.setImage(UIImage(named: "icon_placeholder"), for: .normal)
            cell.lbTitle.text = "beer"
            return cell
        }
        let cell = clUserInteresting.dequeueReusableCell(withReuseIdentifier: "interestingUser", for: indexPath) as! InteterstingUserCell
        let listNotifi = notifications[indexPath.row]
        let listActor = listNotifi.actors?.first
        let listFollow = listNotifi.follows?.first
        if listActor?.user_image != nil{
            BaseAPI.shard.downloadImage(url: listActor?.user_image ?? "") { (img) in
                if let img = img{
                    cell.ImgUser.image = img
                } else {
                    cell.ImgUser.image = nil
                }
            }
        } else {
            BaseAPI.shard.downloadImage(url: listFollow?.user_image ?? "") { (img) in
                if let img = img{
                    cell.ImgUser.image = img
                } else {
                    cell.ImgUser.image = nil
                }
            }
        }
        return cell
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvRecommendUser.dequeueReusableCell(withIdentifier: "recommendUserCell", for: indexPath) as! RecommendUserCell
        let dataComments = comments[indexPath.row]
        cell.lbNameUser.text = dataComments.user?.dataU?.name
        BaseAPI.shard.downloadImage(url: dataComments.user?.dataU?.profileImage ?? "") { (img) in
            if let img = img{
                cell.imgUser.image = img
            } else {
                cell.imgUser.image = nil
            }
        }
        cell.btnFollow.setTitle("Follow", for: .normal)
        return cell
    }
    
    
}
