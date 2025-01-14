//
//  FoodViewController.swift
//  Real Food
//
//  Created by Jonathan Green on 1/26/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import ChameleonFramework
import BTNavigationDropdownMenu
import Kingfisher

class FoodViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let menu = getMenu.sharedInstance
    let presenter = PresentList()
    
    var type:String!
    var miles:Double!
    
    let cellIdentefier = "Food"

    @IBOutlet weak var TableView: UITableView!
    var menuView: BTNavigationDropdownMenu!
    
    var itemArray:[Item] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        miles = 50
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.TableView.addSubview(self.refreshControl) // not required when using UITableViewController
        
        
        
        print(type)
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        menu.setupMenu(self,title:type)
        
        presenter.getItems(type,miles:miles) { (data) -> Void in
            
            print(self.type)
            
            self.itemArray.removeAll()
            
            self.itemArray = data
            
            self.reload()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        presenter.getItems(type,miles:miles) { (data) -> Void in
            
            print(self.type)
            
            self.itemArray.removeAll()
            
            self.itemArray = data
            
            self.refreshControl.endRefreshing()
            
            self.reload()
        }
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.TableView.reloadData()
        });
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FoodCell = tableView.dequeueReusableCellWithIdentifier(cellIdentefier) as! FoodCell
        
         //cell.contentView.backgroundColor = UIColor(contrastingBlackOrWhiteColorOn: self.navigationController?.navigationBar.barTintColor, isFlat: true)
        
        dispatch_async(dispatch_get_main_queue(), {
            
            print(self.itemArray[indexPath.row].image)
            
            cell.cellImage.kf_setImageWithURL(NSURL(string: self.itemArray[indexPath.row].image)!, placeholderImage: UIImage(named:"placeholder"))
            cell.userIcon.kf_setImageWithURL(NSURL(string: self.itemArray[indexPath.row].profileImage)!, placeholderImage: UIImage(named: "placeholder"))
            cell.mainLabel.text = self.itemArray[indexPath.row].userName
            cell.foodDescription.text = self.itemArray[indexPath.row].description
            cell.distance.text = self.itemArray[indexPath.row].distance
            
            print("cell \(self.itemArray[indexPath.row].userName)")
            
            let imageColor = UIColor(averageColorFromImage:cell.cellImage.image)
            
            cell.layoutSubviews()
        });
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 250
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let indexPath = self.TableView.indexPathForSelectedRow
        
        if segue.identifier == "seller" {
            
            let controller = segue.destinationViewController as! SellerViewController
            
            print("user id \(self.itemArray[indexPath!.row].objectId)")
            
            controller.sellerId = self.itemArray[indexPath!.row].objectId
            controller.sellerIcon = self.itemArray[indexPath!.row].profileImage
            controller.sellerName = self.itemArray[indexPath!.row].userName
            controller.itemIcon = self.itemArray[indexPath!.row].image
            controller.sellerDistance = self.itemArray[indexPath!.row].distance
        }
    }
    

}
