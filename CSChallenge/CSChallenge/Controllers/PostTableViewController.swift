//
//  PostTableViewController.swift
//  CSChallenge
//
//  Created by Ethan D'Mello on 2018-09-28.
//  Copyright © 2018 Ethan D'Mello. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostTableViewController: UITableViewController {
    var posts = [Post](){
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiToContact = "https://www.reddit.com/.json"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result{
            case .success:
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    let json_children = json["data"]["children"].array
                    print(json)
                    
                    if let json_children = json_children{
                        self.posts = json_children.flatMap({
                            Post.init(json:$0)
                        })
                        print(self.posts)
                        print(self.posts.count)
                        
                        
                    }
                }
                
            case .failure(let error):
                print("API request did not succeed")
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as! PostTableViewCell
        
        // 2
        //cell.textLabel!.numberOfLines = 0
        cell.postTitleLabel.numberOfLines = 0
        //cell.textLabel!.lineBreakMode = .byWordWrapping
        cell.postTitleLabel.lineBreakMode = .byWordWrapping
        //cell.textLabel!.font = UIFont.systemFont(ofSize: 14.0)
        cell.postTitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        let post = self.posts[indexPath.row]
        cell.postTitleLabel.text = post.title
  
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
