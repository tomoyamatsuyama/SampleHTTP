//
//  ViewController.swift
//  SampleHTTP
//
//  Created by 松山友也 on 2017/11/17.
//  Copyright © 2017年 Tomoya Matsuyama. All rights reserved.
//

import UIKit
import Foundation

struct User: Codable{
    var description: String?
    var facebook_id: String?
    var followees_count: Int?
    var followers_count: Int?
    var github_login_name: String?
    var id: String?
    var items_count: Int?
    var linkedin_id: String?
    var location: String?
    var name: String?
    var organization: String?
    var permanent_id: Int?
    var profile_image_url: URL?
    var twitter_screen_name: String?
    var website_url: String?
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var githubLists: [String] = []
    var userLists: [String] = []
    var followLists: [String] = []
    var accountLists: [String] = []
    var imageLists: [Data] = []
    var searchText: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! CustomTableViewCell
        cell.followlabel.text! = followLists[indexPath.row]
        cell.githublabel.text! = githubLists[indexPath.row]
        cell.namelabel.text! = userLists[indexPath.row]
        cell.idLabel.text! = accountLists[indexPath.row]
        let imgData = imageLists[indexPath.row]
        let img = UIImage(data: imgData as Data)
        cell.imgView.image = img
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "検索結果"
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルをクリックした時に呼ばれるメソッド。collectionも似た感じ
        
        let name: String = self.searchText[indexPath.row]
        if name != nil{
            self.performSegue(withIdentifier: "NextToWeb", sender: name)  //セグエで指定した名前
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let WebViewController = segue.destination as! WebViewController
        WebViewController.url = sender as! String  //値を渡す先の変数を指定。
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let userName = searchBar.text!
         
        guard
            let encodedUsername = userName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://qiita.com/api/v2/users/\(encodedUsername)")
            else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(User.self, from: data)
                
                guard let githubName = object.github_login_name else { return }
                guard let followeesCount = object.followees_count else { return }
                guard let id = object.id else { return }
                guard let imageData = object.profile_image_url else { return }
                guard let name = object.name else { return }
                self.userLists.append("ユーザ名: " + name)
                self.githubLists.append("github: " + githubName)
                self.followLists.append("フォロー数: \(followeesCount)")
                self.accountLists.append("id: " + id)
                DispatchQueue.main.async {
                    self.searchText.append(searchBar.text!)
                }
                
                do {
                    let imgData = try NSData(contentsOf: imageData, options: NSData.ReadingOptions.mappedIfSafe)
                    self.imageLists.append(imgData as Data)
                } catch {
                    print("Error: can't create image.")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let e {
                print(e)
            }
        }
        task.resume()
        tableView.reloadData()
    }

}

