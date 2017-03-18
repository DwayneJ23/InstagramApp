//
//  CustomPostTableViewCell.swift
//  InstagramApp
//
//  Created by Dwayne Johnson on 3/17/17.
//  Copyright © 2017 GroupDiscountApp. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CustomPostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timePostLabel: UILabel!
    
    var post: PFObject!{
        didSet{
            self.postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            
            postCaptionLabel.text = post["caption"] as? String
            
            let user = post["author"] as? PFObject
            
            user?.fetchInBackground(block: { (name: PFObject?, error: Error?) in
                let userName = name?["username"] as? String
                
                self.username.text = userName
            })
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, MMM d, h:mm a"
            let time = post.createdAt! as Date
            timePostLabel.text = String(format: "%@", formatter.string(from: time))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
