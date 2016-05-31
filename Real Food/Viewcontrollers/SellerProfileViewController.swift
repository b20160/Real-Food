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
import ImagePickerSheetController
import Photos
import SwiftSpinner
import Kingfisher
import Cartography

class SellerProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    let menu = getMenu.sharedInstance
    let presenter = PresentList()
    
    let cellIdentefier = "Food"
    
    var edit:UIButton!
    
    let VEGGIES = "Veggies"
    let SWEETS = "Sweets"
    let POULTRY = "Poultry"
    let LAMB = "Lamb"
    let GOAT = "Goat"
    let EGGS = "Eggs"
    let DARIY = "Dariy"
    let BOVINE = "Bovine"
    let BEER = "Beer"
    
    var type:String!
    var image:UIImage!
    var itemsArray:[Item] = []

    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var cancle: FabButton!
    @IBOutlet weak var camera: FabButton!
    @IBOutlet weak var addItem: FabButton!
    @IBOutlet weak var cover: UIView!
    @IBOutlet weak var ratingTable: UITableView!
    @IBOutlet weak var rating: FabButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var addButton: FabButton!
    @IBOutlet weak var closeReview: RaisedButton!
    @IBOutlet weak var newItemView: UIView!
    @IBOutlet weak var newItemImage: UIImageView!
    
    
    @IBOutlet weak var veggie: FabButton!
    @IBOutlet weak var sweets: FabButton!
    @IBOutlet weak var dariy: FabButton!
    @IBOutlet weak var eggs: FabButton!
    @IBOutlet weak var poultry: FabButton!
    @IBOutlet weak var bovine: FabButton!
    @IBOutlet weak var goat: FabButton!
    @IBOutlet weak var lamb: FabButton!
    @IBOutlet weak var beer: FabButton!
    
    
    var itemTitle:TextField!
    
    let imageArray:[String] = ["beans","carrots","cucumbers","greens","peas","peppers","tomatoes",]
    let titleArray:[String] = ["Beans","Carrots","Cucumbers","Greens","Peas","Peppers","Tomatoes",]
    let descriptionArray:[String] = ["Come get some tasty beans","Come get some tasty carrots","Come get some tasty cucumbers","Come get some tasty greens","Come get some tasty peas","Come get some tasty peppers","Come get some tasty tomatoes",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newItemView.layer.cornerRadius = 3
        self.newItemView.layer.masksToBounds = true
        
        menu.setupMenu(self,title: "Profile")
        
        makeButton()
        makeTextFields()
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatSandColorDark()
        
         self.bgImage.clipsToBounds = true
        
          dispatch_async(dispatch_get_main_queue(), {
            
            self.setupLayouts()
            
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
    
    override func viewWillAppear(animated: Bool) {
        
        ratingTable.hidden = true
        cover.hidden = true
        closeReview.hidden = true
        newItemView.hidden = true
        buttonView.hidden = true
        
        presenter.getMyItems { (data) -> Void in
            
            print("got data")
            
            print(data.count)
            
            self.itemsArray.removeAll()
            
            self.itemsArray = data
            
            self.reload()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.bgImage.kf_setImageWithURL(NSURL(string: self.itemsArray[0].profileImage)!, placeholderImage: UIImage(named: "placeholder"))
        self.userImage.kf_setImageWithURL(NSURL(string: self.itemsArray[0].profileImage)!, placeholderImage: UIImage(named: "placeholder"))
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        menu.menuView.hide()
    }
    
    func setupLayouts(){
        
        constrain(tableView,bgImage) { tableView,bgImage in
            
            tableView.width == (tableView.superview?.width)!
            tableView.left == (tableView.superview?.left)!
        }
    }
    
    func reload(){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
        });
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if ratingTable.hidden == false {
            
            let cell:ReviewCell = tableView.dequeueReusableCellWithIdentifier("Review") as! ReviewCell
            
            dispatch_async(dispatch_get_main_queue(), {
            
            cell.reviewLbl.text = "She had the best tasting sweet potatoes I've ever had and her graden is just beutiful"
            });
            
            return cell
            
        }else {
            
            let cell:FoodCell = tableView.dequeueReusableCellWithIdentifier(cellIdentefier) as! FoodCell
            
            dispatch_async(dispatch_get_main_queue(), {
                
                let image = self.itemsArray[indexPath.row].image
                
                cell.cellImage.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: UIImage(named: "placeholder"))
                cell.mainLabel.text = self.itemsArray[indexPath.row].userName
                cell.foodDescription.text = self.itemsArray[indexPath.row].description
                cell.userIcon.kf_setImageWithURL(NSURL(string: self.itemsArray[indexPath.row].profileImage)!, placeholderImage: UIImage(named: "placeholder"))
                
                cell.layoutSubviews()
            });
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 250
    }
    
    
    func reload(table:UITableView){
        
        dispatch_async(dispatch_get_main_queue(), {
            
            table.reloadData()
        })
    }
    
    func makeTextFields(){
        
        itemTitle = TextField(frame: CGRectMake(10, self.newItemView.bounds.height + 70, self.newItemView.frame.width + 100 , 24))
        itemTitle.placeholder = "Description"
        itemTitle.font = RobotoFont.regularWithSize(20)
        itemTitle.textColor = UIColor.flatWhiteColor()
        itemTitle.titleLabel = UILabel()
        itemTitle.titleLabel!.font = RobotoFont.mediumWithSize(12)
        itemTitle.titleLabelColor = MaterialColor.grey.base
        itemTitle.titleLabelActiveColor = UIColor.flatSandColorDark()
        itemTitle.backgroundColor = UIColor.clearColor()
        itemTitle.clearButtonMode = .Always
        self.newItemView.addSubview(itemTitle)
    }
    
    func makeButton(){
        
        veggie.setImage(UIImage(named: "Vegetable"), forState: UIControlState.Normal)
        sweets.setImage(UIImage(named: "Fruit-1"), forState: UIControlState.Normal)
        dariy.setImage(UIImage(named: "cheese"), forState: UIControlState.Normal)
        eggs.setImage(UIImage(named: "eggs"), forState: UIControlState.Normal)
        poultry.setImage(UIImage(named: "chicken"), forState: UIControlState.Normal)
        bovine.setImage(UIImage(named: "cow-1"), forState: UIControlState.Normal)
        goat.setImage(UIImage(named: "goat-1"), forState: UIControlState.Normal)
        lamb.setImage(UIImage(named: "lamb-1"), forState: UIControlState.Normal)
        beer.setImage(UIImage(named: "beer"), forState: UIControlState.Normal)
        
        veggie.imageView?.contentMode = .ScaleAspectFit
        sweets.imageView?.contentMode = .ScaleAspectFit
        dariy.imageView?.contentMode = .ScaleAspectFit
        eggs.imageView?.contentMode = .ScaleAspectFit
        poultry.imageView?.contentMode = .ScaleAspectFit
        bovine.imageView?.contentMode = .ScaleAspectFit
        goat.imageView?.contentMode = .ScaleAspectFit
        lamb.imageView?.contentMode = .ScaleAspectFit
        beer.imageView?.contentMode = .ScaleAspectFit
        
        veggie.backgroundColor = UIColor.flatPlumColorDark()
        sweets.backgroundColor = UIColor.flatPlumColorDark()
        dariy.backgroundColor = UIColor.flatPlumColorDark()
        eggs.backgroundColor = UIColor.flatPlumColorDark()
        poultry.backgroundColor = UIColor.flatPlumColorDark()
        bovine.backgroundColor = UIColor.flatPlumColorDark()
        goat.backgroundColor = UIColor.flatPlumColorDark()
        lamb.backgroundColor = UIColor.flatPlumColorDark()
        beer.backgroundColor = UIColor.flatPlumColorDark()
        
        veggie.tintColor = UIColor.flatSandColorDark()
        sweets.tintColor = UIColor.flatSandColorDark()
        dariy.tintColor = UIColor.flatSandColorDark()
        eggs.tintColor = UIColor.flatSandColorDark()
        poultry.tintColor = UIColor.flatSandColorDark()
        bovine.tintColor = UIColor.flatSandColorDark()
        goat.tintColor = UIColor.flatSandColorDark()
        lamb.tintColor = UIColor.flatSandColorDark()
        beer.tintColor = UIColor.flatSandColorDark()
        
        veggie.setTitle("", forState: UIControlState.Normal)
        sweets.setTitle("", forState: UIControlState.Normal)
        dariy.setTitle("", forState: UIControlState.Normal)
        eggs.setTitle("", forState: UIControlState.Normal)
        poultry.setTitle("", forState: UIControlState.Normal)
        bovine.setTitle("", forState: UIControlState.Normal)
        goat.setTitle("", forState: UIControlState.Normal)
        lamb.setTitle("", forState: UIControlState.Normal)
        beer.setTitle("", forState: UIControlState.Normal)
        
        veggie.imageEdgeInsets.top = 0
        veggie.imageEdgeInsets.bottom = 0
        veggie.imageEdgeInsets.right = -30
        veggie.imageEdgeInsets.left = 15
        
        sweets.imageEdgeInsets.top = 0
        sweets.imageEdgeInsets.bottom = 0
        sweets.imageEdgeInsets.right = -30
        sweets.imageEdgeInsets.left = 15
        
        dariy.imageEdgeInsets.top = 0
        dariy.imageEdgeInsets.bottom = 0
        dariy.imageEdgeInsets.right = -30
        dariy.imageEdgeInsets.left = 15
        
        eggs.imageEdgeInsets.top = 0
        eggs.imageEdgeInsets.bottom = 0
        eggs.imageEdgeInsets.right = -30
        eggs.imageEdgeInsets.left = 15
        
        poultry.imageEdgeInsets.top = 0
        poultry.imageEdgeInsets.bottom = 0
        poultry.imageEdgeInsets.right = -30
        poultry.imageEdgeInsets.left = 15
        
        bovine.imageEdgeInsets.top = 0
        bovine.imageEdgeInsets.bottom = 0
        bovine.imageEdgeInsets.right = -30
        bovine.imageEdgeInsets.left = 15
        
        goat.imageEdgeInsets.top = 0
        goat.imageEdgeInsets.bottom = 0
        goat.imageEdgeInsets.right = -30
        goat.imageEdgeInsets.left = 15
        
        lamb.imageEdgeInsets.top = 0
        lamb.imageEdgeInsets.bottom = 0
        lamb.imageEdgeInsets.right = -30
        lamb.imageEdgeInsets.left = 15
        
        beer.imageEdgeInsets.top = 0
        beer.imageEdgeInsets.bottom = 0
        beer.imageEdgeInsets.right = -30
        beer.imageEdgeInsets.left = 15
        
        addButton.backgroundColor = UIColor.flatPlumColorDark()
        addButton.tintColor = UIColor.flatSandColorDark()
        addButton.setImage(UIImage(named: "plus"), forState: UIControlState.Normal)
        addButton.imageEdgeInsets.top = 10
        addButton.imageEdgeInsets.bottom = 10
        addButton.imageEdgeInsets.right = 10
        addButton.imageEdgeInsets.left = 10
        
        rating.backgroundColor = UIColor.clearColor()
        rating.tintColor = UIColor.flatWhiteColor()
        rating.setTitle("4.3", forState: UIControlState.Normal)
        rating.titleLabel?.font = RobotoFont.mediumWithSize(32)
        
        closeReview.setTitle("Close", forState: .Normal)
        closeReview.titleLabel!.font = RobotoFont.mediumWithSize(32)
        closeReview.backgroundColor = UIColor.flatPlumColorDark()
        closeReview.setTitleColor(UIColor.flatSandColorDark(), forState: .Normal)
        
        edit = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        edit.setTitle("Edit", forState: UIControlState.Normal)
        edit.setTitleColor(UIColor.flatSandColorDark(), forState: UIControlState.Normal)
        
        
        camera.setImage(UIImage(named: "camera"), forState: UIControlState.Normal)
        camera.tintColor = UIColor.flatSandColorDark()
        camera.backgroundColor = UIColor.flatPlumColorDark()
        camera.imageEdgeInsets.top = 10
        camera.imageEdgeInsets.bottom = 10
        camera.imageEdgeInsets.right = 10
        camera.imageEdgeInsets.left = 10
        
        addItem.setImage(UIImage(named: "plus"), forState: UIControlState.Normal)
        addItem.tintColor = UIColor.flatSandColorDark()
        addItem.backgroundColor = UIColor.flatPlumColorDark()
        addItem.imageEdgeInsets.top = 10
        addItem.imageEdgeInsets.bottom = 10
        addItem.imageEdgeInsets.right = 10
        addItem.imageEdgeInsets.left = 10
        
        cancle.setImage(UIImage(named: "close-box"), forState: UIControlState.Normal)
        cancle.tintColor = UIColor.flatSandColorDark()
        cancle.backgroundColor = UIColor.flatPlumColorDark()
        cancle.imageEdgeInsets.top = 10
        cancle.imageEdgeInsets.bottom = 10
        cancle.imageEdgeInsets.right = 10
        cancle.imageEdgeInsets.left = 10
        
        let rightButton = UIBarButtonItem.init(customView: edit)
        
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @IBAction func add(sender: AnyObject) {
        
        buttonView.hidden = false
        cover.hidden = false
    }
  
    @IBAction func addItemBtn(sender: AnyObject) {
        
        guard (image != nil) else {
            
            return
        }
        
        guard (itemTitle.text != nil) else {
            
            return
        }
        
         SwiftSpinner.show("Adding Item")
        
        presenter.makeItem(type, name: itemTitle.text!, image: image) { (success) -> Void in
            
            if success == true {
                
                    print("Item Saved Successfully")
                    self.newItemView.hidden = true
                    self.cover.hidden = true
                    
                    self.presenter.getMyItems { (data) -> Void in
                        
                        self.itemsArray.removeAll()
                        
                        self.itemsArray = data
                        
                        self.reload()
                        
                        SwiftSpinner.hide()
                    }
                
                
            }else {
                
                SwiftSpinner.hide({
                    
                    print("There was an issue saving your item")
                })
                
            }
        }
        
    }
    
    @IBAction func cameraBtn(sender: AnyObject) {
        
        getImage()
        
    }
    
    @IBAction func cancelBtn(sender: AnyObject) {
        
        newItemView.hidden = true
        cover.hidden = true
    }
    
    @IBAction func ratingBtn(sender: AnyObject) {
        
        ratingTable.hidden = false
        ratingTable.dataSource = self
        ratingTable.delegate = self
        tableView.delegate = nil
        tableView.dataSource = nil
        cover.hidden = false
        closeReview.hidden = false
        
        reload(ratingTable)
    }
    
    @IBAction func closeReviewBtn(sender: AnyObject) {
        
        ratingTable.hidden = true
        ratingTable.dataSource = nil
        ratingTable.delegate = nil
        tableView.delegate = self
        tableView.dataSource = self
        cover.hidden = true
        closeReview.hidden = true
        
        reload(tableView)
    }
    
    @IBAction func veggieBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = VEGGIES
        
        getImage()
    }
    
    @IBAction func sweetsBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = SWEETS
        
        getImage()
    }
    
    @IBAction func dairyBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = DARIY
        
        getImage()
    }
    
    @IBAction func eggsBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = EGGS
        
        getImage()
    }
    
    @IBAction func poultryBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = POULTRY
        
        getImage()
    }
    
    @IBAction func bovineBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = BOVINE
        
        getImage()
    }
    
    @IBAction func goatBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = GOAT
        
        getImage()
    }
    
    @IBAction func lambBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = LAMB
        
        getImage()
    }
    
    @IBAction func beerBtn(sender: AnyObject) {
        
        newItemView.hidden = false
        cover.hidden = false
        buttonView.hidden = true
        type = BEER
        
        getImage()
    }
    
    
    func getImage() {
        
        let manager = PHImageManager.defaultManager()
        let initialRequestOptions = PHImageRequestOptions()
        initialRequestOptions.resizeMode = .Fast
        initialRequestOptions.deliveryMode = .HighQualityFormat
        
        let presentImagePickerController: UIImagePickerControllerSourceType -> () = { source in
            let controller = UIImagePickerController()
            controller.delegate = self
            var sourceType = source
            if (!UIImagePickerController.isSourceTypeAvailable(sourceType)) {
                sourceType = .PhotoLibrary
                print("Fallback to camera roll as a source since the simulator doesn't support taking pictures")
            }
            controller.sourceType = sourceType
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
        let controller = ImagePickerSheetController(mediaType: .Image)
        controller.maximumSelection = 1
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Take Photo", comment: "Action Title"), secondaryTitle: NSLocalizedString("Use This Image", comment: "Action Title"), handler: { _ in
            presentImagePickerController(.Camera)
            }, secondaryHandler: { action, numberOfPhotos in
                print("Comment \(numberOfPhotos) photos")
                
                let size = CGSize(width: controller.selectedImageAssets[0].pixelWidth, height: controller.selectedImageAssets[0].pixelHeight)
                
                manager.requestImageForAsset(controller.selectedImageAssets[0],
                    targetSize: size,
                    contentMode: .AspectFill,
                    options:initialRequestOptions) { (finalResult, _) in
                        
                        self.newItemImage.image = finalResult
                        self.image = finalResult
                }
                
                
        }))
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .Cancel, handler: { _ in
            print("Cancelled")
        }))
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            controller.modalPresentationStyle = .Popover
            controller.popoverPresentationController?.sourceView = view
            controller.popoverPresentationController?.sourceRect = CGRect(origin: view.center, size: CGSize())
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
