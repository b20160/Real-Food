//
//  FoodCell.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Material
import FXBlurView

class FoodCell: UITableViewCell {
    
   
    @IBOutlet weak var imageFadeView: UIView!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        dispatch_async(dispatch_get_main_queue(), {
            
            
            
           
            /*self.fadeView.layer.cornerRadius = 3
            self.fadeView.layer.masksToBounds = true
            
            self.fadeView2.layer.cornerRadius = 3
            self.fadeView2.layer.masksToBounds = true*/
            
            self.selectionStyle = .None
            
            self.userIcon.layer.cornerRadius = self.userIcon.layer.frame.height/2
            
            self.userIcon.layer.masksToBounds = true
            
            //self.cellView.layer.shadowOffset = CGSizeMake(0, 10); //default is (0.0, -3.0)
            //self.cellView.layer.shadowColor = UIColor.flatGrayColorDark().CGColor //default is black
            //self.cellView.layer.shadowRadius = 5.0; //default is 3.0
           // self.cellView.layer.shadowOpacity = 0.5; //default is 0.0
            
            self.cellImage.layer.cornerRadius = 4
            self.cellImage.layer.masksToBounds = true
            
            self.imageFadeView.layer.cornerRadius = 4
            self.imageFadeView.layer.masksToBounds = true

            
            self.foodDescription.font = RobotoFont.mediumWithSize(24)
            self.mainLabel.font = RobotoFont.mediumWithSize(17)
            
        });
    }
    
   

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
