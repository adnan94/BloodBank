//
//  RequestsViewController.swift
//  Copy Docket
//
//  Created by Mac on 13/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import JGProgressHUD

class RequestsViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    var itemHeight:CGFloat = 100
    var list:Array<Request> = Array<Request>()
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud:JGProgressHUD!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
inits()
    }
    
  
    override func viewDidAppear(_ animated: Bool) {

    }
    
    func callClicked(pos: Int) {
        
    }
    
    
  
}


extension RequestsViewController : UITableViewDelegate,UITableViewDataSource , HomeScreenResponder{
    
    func inits(){
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.tableFooterView = UIView()
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        
        
        mainTableView.register(UINib(nibName: "BloodRequests", bundle: nil), forCellReuseIdentifier: "BloodRequests")
        
        
        getDevice()
        
        if shared.user!.profileCompleted{
            getDonors()
        }

    }
    func chatClicked(pos: Int) {
        var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        var vc = secondStoryBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
          vc.opponent = self.list[pos].user
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodRequests") as! BloodRequests
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.preservesSuperviewLayoutMargins = false
        tableView.backgroundColor = UIColor.clear
        cell.responder = self
        cell.position = indexPath.row
        
        
        cell.usernamee.text = self.list[indexPath.row].user.name
        cell.bloodGroup.text = "Needs : "+self.list[indexPath.row].bloodGroup+"\n"+"Till - "+formaterDate(date: self.list[indexPath.row].expiry)
        
        if self.self.list[indexPath.row].user.picUrl!.count > 5{
            let url = URL(string: self.list[indexPath.row].user.picUrl!)
            cell.picture.kf.setImage(with: url)
        }
        return cell
    }
    
    
    @IBAction func addRequest(_ sender: Any) {
        var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        var vc = secondStoryBoard.instantiateViewController(withIdentifier: "AddRequestViewController") as! AddRequestViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
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
    
    
    func getDonors(){
        
        self.hud.show(in: self.view); ref.child("Requests").queryOrdered(byChild:"bloodGroup").queryEqual(toValue:self.shared.user!.bloodGroup).observe(.value) { snapshot in
            if snapshot.exists() {
                self.list.removeAll()
                self.mainTableView.reloadData()
                for item in snapshot.children{
                    var datashot:DataSnapshot = item as! DataSnapshot
                    var request = try! FirebaseDecoder().decode(Request.self, from: datashot.value!)
                    if request.id.elementsEqual(self.shared.user!.id!) == false
                        && request.bloodGroup.elementsEqual(self.shared.user!.bloodGroup!)
                        && request.gender.elementsEqual(self.shared.user!.gender!)
                        && request.expiry < currentTimeInMilli()
                    {
                        self.getUser(request:request)
                        
                    }
                }
                self.hud.dismiss()
                
            }else{
                self.list.removeAll()
                self.mainTableView.reloadData()

                self.hud.dismiss()
                
            }
            
            
            
            
        }
    }
    
    func getUser(request:Request){
      
        ref.child("Users").child(request.userID).observe(.value) { snapshot in
            
            if snapshot.exists(){
                if snapshot.exists() {
                    var datashot:DataSnapshot = snapshot as! DataSnapshot
                    var user = try! FirebaseDecoder().decode(User.self, from: datashot.value!)
                    request.user = user
                    self.list.append(request)
                    self.mainTableView.reloadData()
                    
                    
                }else{
                    self.hud.dismiss()
                    
                }
                
            }
            
        }
        
    }
    
}
protocol RequestScreenResponder{
    func chatClicked(pos:Int)
    func callClicked(pos:Int)
}
