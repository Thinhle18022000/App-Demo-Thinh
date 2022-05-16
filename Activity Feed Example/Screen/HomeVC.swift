//
//  HomeVC.swift
//  Activity Feed Example
//
//  Created by ThinhLDH on 28/04/2022.
//

import UIKit

class HomeVC: BaseVC {

    var activite:[ActivitesMD] = []
    @IBOutlet weak var tablePost: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tablePost.delegate = self
        self.tablePost.dataSource = self
        getData()
    }
    @IBAction func ProfileNVG(_ sender: Any) {
        let push = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "profileVC")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    func getData(){
        HomeAPI().getHome { [weak self] result in
            switch result{
                case .success(let data):
                    self?.activite = data
                    self?.tablePost.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        let cell = tablePost.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        let dataActives = activite[indexPath.row]
        BaseAPI.shard.downloadImage(url: dataActives.author?.user_image ?? "") { (image) in
            if let image = image{
                cell.imgAvatar.image = image
            } else {
                cell.imgAvatar.image = nil
            }
        }
        cell.nameUser.text = dataActives.author?.name
        cell.timeActive.text = dataActives.timestamp + " ago"
        cell.captions.text = dataActives.content
        if dataActives.image != ""{
            BaseAPI.shard.downloadImage(url: dataActives.image) { (image) in
                if let image = image{
                    cell.imgContent.image = image
                } else {
                    cell.imgContent.image = nil
                }
            }
//            let dataImage:Data? = try? Data(contentsOf: URL(string: dataActives.author?.user_image ?? "")! )
//           // cell.avatar.imageView?.loadFrom(URLAddress: dataActives.author?.user_image ?? "")
//            cell.imgContent.image = UIImage(data: dataImage!)
            cell.hightImg.constant = 250
        } else {
            cell.hightImg.constant = 0
        }
        return cell
    }
}
