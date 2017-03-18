//
//  PostViewController.swift
//  InstagramApp
//
//  Created by Dwayne Johnson on 3/17/17.
//  Copyright © 2017 GroupDiscountApp. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var postTableView: UITableView!
    
    var posts: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        retrievePost()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrievePost() {
    
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground {(posts: [PFObject]?, error: Error?) in
            if let posts = posts {
            
                print("success")
                self.posts = posts
                self.postTableView.reloadData()
                
            } else {
            
                print("failed to retrieve data : \(error!.localizedDescription)")
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! CustomPostTableViewCell

        cell.post = posts[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
