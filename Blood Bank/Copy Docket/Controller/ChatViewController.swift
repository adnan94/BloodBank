//
//  ChatViewController.swift
//  Copy Docket
//
//  Created by Mac on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var itemHeight:CGFloat = 30
    var list:Array<String> = Array<String>()

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        tableViewWork()
        getDevice()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    
    }

    
  
  

    @IBAction func sendButton(_ sender: Any) {
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableViewWork(){
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        mainTableView.register(UINib(nibName: "ChatRight", bundle: nil), forCellReuseIdentifier: "ChatRight")
        mainTableView.register(UINib(nibName: "ChatLeft", bundle: nil), forCellReuseIdentifier: "ChatLeft")
        
        list.append("")
        list.append("")
        list.append("")
        list.append("")
        list.append("")

    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell:UITableViewCell!
        
        if indexPath.row % 2 == 0{
        cell = tableView.dequeueReusableCell(withIdentifier: "ChatRight") as! ChatRight
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.preservesSuperviewLayoutMargins = false
        tableView.backgroundColor = UIColor.clear
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatLeft") as! ChatLeft
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.preservesSuperviewLayoutMargins = false
            tableView.backgroundColor = UIColor.clear
            
        }
        return cell
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
