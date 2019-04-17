//
//  ConversationsViewController.swift
//  Copy Docket
//
//  Created by Mac on 13/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ConversationsViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    var itemHeight:CGFloat = 100
    var list:Array<String> = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.tableFooterView = UIView()
        
        mainTableView.register(UINib(nibName: "ConversationsXib", bundle: nil), forCellReuseIdentifier: "ConversationsXib")
        
        list.append("")
        list.append("")
        list.append("")
        list.append("")
        list.append("")
        
        getDevice()
        
        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsXib") as! ConversationsXib
      
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
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
        self.navigationController?.pushViewController(vc, animated: true)
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
