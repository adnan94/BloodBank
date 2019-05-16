//
//  ChatViewController.swift
//  Copy Docket
//
//  Created by Mac on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import JGProgressHUD
import Kingfisher

class ChatViewController: UIViewController {
    
    var itemHeight:CGFloat = 30
    var list:Array<SingleMessage> = Array<SingleMessage>()

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    var opponent:User!
    var contact:Bool!
    var hud:JGProgressHUD!
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var conversationID:String!
    var removeLinkHandler: DatabaseHandle!
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       inits()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if let r = self.removeLinkHandler {
         ref.removeObserver(withHandle: self.removeLinkHandler)
        }
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }

    
  
  

    @IBAction func sendButton(_ sender: Any) {
        if self.messageField.text?.isEmpty == false{
            if contact == false{
            addToContact()
            }else{
//                            self.messageField.text = ""
                sendMessage()
                
            }

        }else{
            toast(controller: self, message: "Enter message", seconds: 1.0)
        }
    }
    
    
}
extension ChatViewController : UITableViewDelegate,UITableViewDataSource{

    func setUserData(){
        if self.opponent.picUrl!.count > 5{
            let url = URL(string: self.opponent.picUrl!)
            self.picture.kf.setImage(with: url)
        }
        
        self.userName.text = self.opponent.name!
        
    }
    
    func inits(){
       
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
      
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        
        if  self.opponent.id > self.shared.user!.id{
            self.conversationID = self.shared.user!.id+"|"+self.opponent.id
            
        }else{
            self.conversationID = self.opponent.id+"|"+self.shared.user!.id
            
        }
        
        setUserData()
        getDevice()
        tableViewWork()
        checkForContact()
        loadConversation()
        
    }
    
    func loadConversation(){
        var refer = Database.database().reference()
        self.hud.dismiss()
            refer =  refer.child("AppData").child("ChatData").child(self.conversationID)
        
        
        self.removeLinkHandler = refer.observe(.childChanged, with: { (snapshot) -> Void in
            if snapshot.exists(){
                for item in snapshot.children{
                    var datashot:DataSnapshot = item as! DataSnapshot
                var message:SingleMessage = try! FirebaseDecoder().decode(SingleMessage.self, from:datashot.value!)
                if  let i = message.messageId{
                    self.addToList(m:message)
                }
                }
                self.hud.dismiss()
                
            }else{
                self.hud.dismiss()
            }
        })

    }
    func loadInitially(){
        var refer = Database.database().reference()
        self.hud.dismiss()
        refer =  refer.child("AppData").child("ChatData").child(self.conversationID)
         refer.observeSingleEvent(of: .value, with: { snapshot in
               if snapshot.exists(){
                            for item in snapshot.children{
                                var datashot:DataSnapshot = item as! DataSnapshot
                             
                                
                                
                                for item1 in datashot.children{
                                    var datashot1:DataSnapshot = item1 as! DataSnapshot
                                    
                                var message:SingleMessage = try! FirebaseDecoder().decode(SingleMessage.self, from:datashot1.value!)
                                if  let i = message.messageId{
                                    self.addToList(m:message)
                                }
                                    
                                    
                                    
                                    
                            }
                }
                self.flag = true
                            self.hud.dismiss()
               }else{
                            self.hud.dismiss()
            }
            
        })
     
        
        
    }
    
    
    
    
    func addToList(m:SingleMessage) {
        
        var flag:Bool = true
        for  message in list {
            var mess:SingleMessage = message as! SingleMessage
            if (m.messageId.elementsEqual(mess.messageId)) {
                flag = false
            }
        }
        if (flag) {
            self.list.append(m)
            self.mainTableView.reloadData()
            self.mainTableView.scrollToRow(at: IndexPath(item: self.list.count-1, section: 0), at: .bottom,
                                           animated: true)
        }
        
    }
    func checkForContact(){
        ref.child("Conversations").child(self.shared.user!.id).queryOrdered(byChild: "opponentId").queryEqual(toValue:opponent.id).observeSingleEvent(of: .value, with: { snapshot in
            
            if snapshot.exists() {

                    var request:Conversation = try! FirebaseDecoder().decode(Conversation.self, from: snapshot.value!)
                    self.contact = true
                    self.hud.dismiss()
       
            }else{
                self.contact = false
                self.hud.dismiss()
            }
            
        })
    }
    
    func addToContact(){
        self.hud.show(in: self.view)
        
        var map1:[String:Any] = [:]
        map1["opponentId"] = self.shared.user!.id!
        
        var map2:[String:Any] = [:]
        map2["opponentId"] = self.opponent.id!
        
        
        ref.child("Conversations").child(self.shared.user!.id).childByAutoId().setValue(map2, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print("\(error!.localizedDescription)")
            } else {
                ref.child("Conversations").child(self.opponent.id).childByAutoId().setValue(map1, withCompletionBlock: { (error, snapshot) in
                    if error != nil {
                        print("\(error!.localizedDescription)")
                      self.hud.dismiss()
                    } else {
                        self.contact = true
                        self.hud.dismiss()
                        self.sendMessage()
                    }
                })
            }
        })
    }
    
    func sendMessage(){
    
 //       if self.flag{
   //self.loadConversation()
     //   }
        var refer:DatabaseReference = Database.database().reference().child("AppData")
        
            refer = refer.child("ChatData").child(self.conversationID).child(self.shared.user!.id)
        var push:String = refer.childByAutoId().key!
        var map:[String:Any] = [:]
        map["message"] = self.messageField.text!
        map["timestamp"] = ServerValue.timestamp()
        map["id"] = self.shared.user!.id
        map["messageId"] = push
        map["name"] = self.shared.user!.name
        map["picUrl"] = self.shared.user!.picUrl
        map["type"] = self.shared.user!.type!
    

        refer.child(push).setValue(map, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print("\(error!.localizedDescription)")
            } else {
                //                self.list.append(self.messageField.text!)
                //                self.mainTableView.reloadData()
                self.messageField.text = ""
                self.flag = false
            }
        })

    }
    
    
    
    
    
    
    func tableViewWork(){
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mainTableView.register(UINib(nibName: "ChatRight", bundle: nil), forCellReuseIdentifier: "ChatRight")
        mainTableView.register(UINib(nibName: "ChatLeft", bundle: nil), forCellReuseIdentifier: "ChatLeft")
}
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
        
//        if list[indexPath.row].id.elementsEqual(self.shared.user!.id){
            let cell:ChatRight!
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatRight") as! ChatRight
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.preservesSuperviewLayoutMargins = false
            tableView.backgroundColor = UIColor.clear
            cell.messagee.text = self.list[indexPath.row].message
            cell.datee.text = formaterDate(date: self.list[indexPath.row].timestamp)+" | "+formaterTime(date: self.list[indexPath.row].timestamp)
            return cell
//        }else{
//            let cell:ChatLeft!
//
//            cell = tableView.dequeueReusableCell(withIdentifier: "ChatLeft") as! ChatLeft
//            cell.selectionStyle = UITableViewCell.SelectionStyle.none
//            cell.preservesSuperviewLayoutMargins = false
//            tableView.backgroundColor = UIColor.clear
//            cell.messagee.text = self.list[indexPath.row].message
//            cell.datee.text = formaterDate(date: self.list[indexPath.row].timestamp)+" | "+formaterTime(date: self.list[indexPath.row].timestamp)
//            return cell
//        }
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
                itemHeight  = 30
            case 1334:
                print("iPhone 6/6S/7/8")
                itemHeight  = 35
                
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                itemHeight  = 50
                
            case 2436:
                print("iPhone X, Xs")
                itemHeight  = 40
                
            case 2688:
                print("iPhone Xs Max")
                itemHeight  = 50
                
            case 1792:
                print("iPhone Xr")
                itemHeight  = 50
                
            default:
                itemHeight  = 50
                print("unknown")
            }
        }
    }
}
