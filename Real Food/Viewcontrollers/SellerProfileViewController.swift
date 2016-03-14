//
//  SellerProfileViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 2/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import FXBlurView
import Material

class SellerProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let cellIdentefier = "Food"
    
    var edit:UIButton!

    @IBOutlet weak var rating: FabButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var addButton: FabButton!
    
    let imageArray:[String] = ["beans","carrots","cucumbers","greens","peas","peppers","tomatoes",]
    let titleArray:[String] = ["Beans","Carrots","Cucumbers","Greens","Peas","Peppers","Tomatoes",]
    let descriptionArray:[String] = ["Come get some tasty beans","Come get some tasty carrots","Come get some tasty cucumbers","Come get some tasty greens","Come get some tasty peas","Come get some tasty peppers","Come get some tasty tomatoes",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeButton()
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatSandColorDark()
        
         self.bgImage.clipsToBounds = true
        
          dispatch_async(dispatch_get_main_queue(), {
            
            let blurredImage = self.bgImage.image?.blurredImageWithRadius(20, iterations: 2, tintColor: UIColor.clearColor())
            
            self.bgImage.image = blurredImage
           
            
            self.userImage.layer.cornerRadius = self.userImage.layer.frame.height/2
            self.userImage.layer.borderColor = UIColor.flatSandColorDark().CGColor
            self.userImage.layer.borderWidth = 3
            
            self.userName.font = RobotoFont.mediumWithSize(14)
            self.userName.text = "Sara"
            
            self.userImage.layer.masksToBounds = true
            self.userImage.clipsToBounds = true
            
        });
        
       
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FoodCell = tableView.dequeueReusableCellWithIdentifier(cellIdentefier) as! FoodCell
        
        let image = UIImage(named: self.imageArray[indexPath.row])
        
        //cell.contentView.backgroundColor = UIColor(contrastingBlackOrWhiteColorOn: self.navigationController?.navigationBar.barTintColor, isFlat: true)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            /*cell.fadeView.blurEnabled = true
            cell.fadeView.blurRadius = 20
            cell.fadeView.dynamic = false
            cell.fadeView.clipsToBounds = true
            cell.fadeView.updateAsynchronously(true, completion: { () -> Void in
            
            
            })*/
            
            cell.cellImage.image = image
            cell.mainLabel.text = "Sara"
            cell.foodDescription.text = self.titleArray[indexPath.row]
            
            cell.layoutSubviews()
        });
        
        return cell
    }
    
    func makeButton(){
        
        addButton.backgroundColor = UIColor.flatPlumColorDark()
        addButton.tintColor = UIColor.flatSandColorDark()
        addButton.setImage(UIImage(named: "plus"), forState: UIControlState.Normal)
        addButton.imageEdgeInsets.top = 13
        addButton.imageEdgeInsets.bottom = 13
        addButton.imageEdgeInsets.right = 13
        addButton.imageEdgeInsets.left = 13
        
        rating.backgroundColor = UIColor.clearColor()
        rating.tintColor = UIColor.flatWhiteColor()
        rating.setTitle("4.3", forState: UIControlState.Normal)
        rating.titleLabel?.font = RobotoFont.mediumWithSize(32)
        
        edit = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        edit.setTitle("Edit", forState: UIControlState.Normal)
        edit.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        
        let rightButton = UIBarButtonItem.init(customView: edit)
        
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @IBAction func add(sender: AnyObject) {
        
    }
    
    @IBAction func ratingBtn(sender: AnyObject) {
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
