//
//  HomeScreenViewController.swift
//  Copy Docket
//
//  Created by Mac on 28/02/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import CodableFirebase
import Kingfisher


class HomeScreenViewController: UIViewController , UITableViewDelegate,UITableViewDataSource ,HomeScreenResponder  {
   
   
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backImg: UIImageView!
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var story:UIStoryboard!
    var hud:JGProgressHUD!
    var itemHeight:CGFloat = 100
    var list:Array<String> = Array<String>()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlizers()
        getDevice()
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
     
        if let imge =  shared.template{
            backImg.image = shared.template
        }
        
//        let button =  UIButton(type: .custom)
//        button.setImage(UIImage(named: "upgrade_plan"), for:.normal)
//        button.frame = CGRect(x:0, y:0, width:32, height:32)
//        let barButton = UIBarButtonItem(customView: button)
//        self.navigationItem.leftBarButtonItem = barButton
//        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonorRequests") as! DonorRequests
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.preservesSuperviewLayoutMargins = false
        tableView.backgroundColor = UIColor.clear
        cell.responder = self
        cell.position = indexPath.row
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {

  //      self.title = "Welcome!"
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
        
    }
    
    func chatClicked(pos: Int) {
        var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        var vc = secondStoryBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func callClicked(pos: Int) {
        
    }
    
    
//    @IBAction func goToSettings(_ sender: Any) {
//        try! Auth.auth().signOut()
//        shared.user = nil
//        shared.template = nil
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "loginNavigation") as! UINavigationController
//        //            if let navigationController = self.window?.rootViewController as? UINavigationController{
//        //                navigationController.pushViewController(destinationViewController, animated: false)
//        self.view.window?.rootViewController = destinationViewController
//        self.view.window?.makeKeyAndVisible()
//
//
//    }
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
}


extension HomeScreenViewController{
    
    
    func initlizers(){
        
        
        self.navigationItem.hidesBackButton = true
        self.title = "Donors"
        story = UIStoryboard(name: "Main", bundle: nil)
      
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: view)
    
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.tableFooterView = UIView()
        
        mainTableView.register(UINib(nibName: "DonorRequests", bundle: nil), forCellReuseIdentifier: "DonorRequests")
        
        list.append("")
        list.append("")
        list.append("")
        list.append("")
        list.append("")
        
    self.getUserData()
    }
    
 
    
    func getDevice(){
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                itemHeight  = 80
            case 1334:
                print("iPhone 6/6S/7/8")
                itemHeight  = 90
                
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                itemHeight  = 110
                
            case 2436:
                print("iPhone X, Xs")
                itemHeight  = 110
                
            case 2688:
                print("iPhone Xs Max")
                itemHeight  = 110
                
            case 1792:
                print("iPhone Xr")
                itemHeight  = 110
                
            default:
                itemHeight  = 110
                print("unknown")
            }
        }
    }

   
    func getUserData(){
        ref.child("Users").child(Auth.auth().currentUser!.uid).observe(.value) { snapshot in
            if snapshot.exists(){
                
                let dataShot:DataSnapshot = snapshot as! DataSnapshot
                let data:[String:Any] = dataShot.value as! [String: Any]
                let user = try! FirebaseDecoder().decode(User.self, from: snapshot.value!)
                if user.active! == 0{
                    try! Auth.auth().signOut()
                    self.shared.user = nil
                    self.shared.template = nil
                    self.hud.dismiss()
                    toast(controller: self, message: "Deactive by admin", seconds: 1.0)
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    
                }else{
                    self.shared.user = user
                    
                }
                    self.hud.dismiss()
            }else{
                self.hud.dismiss()
                
            }
        }
        
    }
    
  
}

protocol HomeScreenResponder{
    func chatClicked(pos:Int)
    func callClicked(pos:Int)
}
