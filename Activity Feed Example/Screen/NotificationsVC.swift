//
//  NotificationsVC.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 28/04/2022.
//

import UIKit

class NotificationsVC: BaseVC {

    @IBOutlet weak var tbNotification: UITableView!
    var notifications:[NotificationsMD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbNotification.delegate = self
        self.tbNotification.dataSource = self
        getNotifications()
    }
    
    func getNotifications(){
        NotificationAPI().getNotification { [weak self] (resultNotfi) in
            switch resultNotfi{
                case .success(let notifi):
                    self?.notifications = notifi
                    self?.tbNotification.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }

}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbNotification.dequeueReusableCell(withIdentifier: "notificationsCell", for: indexPath) as! NotificationsCell
        let listNotifi = notifications[indexPath.row]
        let listActor = listNotifi.actors?.first
        let listFollow = listNotifi.follows?.first
        switch listNotifi.type {
        case "like":
            BaseAPI().downloadImage(url: listActor?.user_image ?? "") { (img) in
                if let img = img {
                    cell.imgUser.image = img
                } else {
                    cell.imgUser.image = nil
                }
            }
            cell.CountUser.text = String(listActor?.user_name ?? "") + String(" and ") + String(listActor?.user_name.count ?? 0 - 1) + " others"
            cell.iconStatus.image = UIImage(named: "repost")
            cell.iconStatus.tintColor = UIColor.link
            cell.lbStatus.text = "Liked post of " + String(listNotifi.objects?.author ?? "")
        case "follow":
            BaseAPI().downloadImage(url: listFollow?.user_image ?? "") { (img) in
                if let img = img {
                    cell.imgUser.image = img
                } else {
                    cell.imgUser.image = nil
                }
            }
            cell.CountUser.text = String(listFollow?.user_name ?? "") + String(" and ") + String(listFollow?.user_name.count ?? 0 - 1) + " others"
            cell.iconStatus.image = UIImage(named: "heart")
            cell.lbStatus.text = "Followed you"
        default:
            BaseAPI().downloadImage(url: listActor?.user_image ?? "") { (img) in
                if let img = img {
                    cell.imgUser.image = img
                } else {
                    cell.imgUser.image = nil
                }
            }
            cell.CountUser.text = String(listActor?.user_name ?? "") + String(" and ") + String(listActor?.user_name.count ?? 0 - 1) + " others"
            cell.iconStatus.image = UIImage(named: "repost")
            cell.iconStatus.tintColor = UIColor.link
            cell.lbStatus.text = "reposted post" + String(listNotifi.objects?.author ?? "")
        }

        if listNotifi.objects?.content != nil{
            cell.lbContent.text = listNotifi.objects?.content
        } else {
            cell.heigthContent.constant = 0
            cell.lbContent.text = nil
            cell.topContent.constant = 0
        }
        
        if listNotifi.objects?.timestamp != nil{
            cell.lbTimestamp.text = String(listNotifi.objects?.timestamp ?? "") + String(" ago")
        } else {
            cell.heightTimeStamp.constant = 0
            cell.lbTimestamp.text = nil
        }
       
        return cell
    }
    
    
}
