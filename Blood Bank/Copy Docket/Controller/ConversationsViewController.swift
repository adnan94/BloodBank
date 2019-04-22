//
//  ConversationsViewController.swift
//  Copy Docket
//
//  Created by Mac on 13/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import JGProgressHUD

class ConversationsViewController: UIViewController  {

    @IBOutlet weak var mainTableView: UITableView!
    var itemHeight:CGFloat = 100
    var list:Array<Conversation> = Array<Conversation>()
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud:JGProgressHUD!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       inits()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getConversation()
    }

}
extension ConversationsViewController :  UITableViewDelegate,UITableViewDataSource{
  
    func inits(){
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.tableFooterView = UIView()
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        
        mainTableView.register(UINib(nibName: "ConversationsXib", bundle: nil), forCellReuseIdentifier: "ConversationsXib")
        getDevice()
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsXib") as! ConversationsXib
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.userNAme.text = self.list[indexPath.row].user!.name
        
        if self.list[indexPath.row].user!.picUrl!.count > 5{
            let url = URL(string: self.list[indexPath.row].user!.picUrl!)
            cell.picture.kf.setImage(with: url)
        }
        
        cell.preservesSuperviewLayoutMargins = false
        tableView.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        var vc = secondStoryBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.opponent = self.list[indexPath.row].user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getConversation(){
        
        self.hud.show(in: self.view); ref.child("Conversations").child(self.shared.user!.id).observe(.value) { snapshot in
            if snapshot.exists() {
                self.list.removeAll()
                self.mainTableView.reloadData()
                for item in snapshot.children{
                    var datashot:DataSnapshot = item as! DataSnapshot
                    var conversation = try! FirebaseDecoder().decode(Conversation.self, from: datashot.value!)
                    
                    self.getUser(conversation:conversation)
                    
                    
                }
                self.hud.dismiss()
                
            }else{
                self.list.removeAll()
                self.mainTableView.reloadData()
                self.hud.dismiss()
                
            }
            
            
            
            
        }
    }
    func getUser(conversation:Conversation){
        ref.child("Users").child(self.shared.user!.id).observe(.value) { snapshot in
            
            if snapshot.exists(){
                if snapshot.exists() {
                    var datashot:DataSnapshot = snapshot as! DataSnapshot
                    var user = try! FirebaseDecoder().decode(User.self, from: datashot.value!)
                    conversation.user = user
                    self.list.append(conversation)
                    self.mainTableView.reloadData()
                    
                    
                }else{
                    self.hud.dismiss()
                    
                }
                
            }
            
        }
        
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

}
