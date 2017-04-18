//
//  HomeScreenCell.swift
//  InstaFake
//
//  Created by my mac on 4/1/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class HomeScreenCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var captionText: UILabel!
    
    
    var instaFakePost: PFObject!{
        didSet{
            self.photoView.file = instaFakePost["media"] as! PFFile?
            self.captionText.text = instaFakePost["caption"] as! String
            
            self.photoView.loadInBackground()
        
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
