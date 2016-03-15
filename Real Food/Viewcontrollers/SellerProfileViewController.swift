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

class SellerProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    let menu = getMenu()
    
    let cellIdentefier = "Food"
    
    var edit:UIButton!

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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageArray.count
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
        
        newItemView.hidden = false
        cover.hidden = false
        
        getImage()
    }
  
    @IBAction func addItemBtn(sender: AnyObject) {
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
