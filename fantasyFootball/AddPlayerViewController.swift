//
//  AddPlayerViewController.swift
//  fantasyFootball
//
//  Created by Rohan Lokesh Sharma on 20/06/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class AddPlayerViewController: UIViewController {
    
    var players = [Players]()
    
    lazy var myTableView:UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.delegate = self;
        view.dataSource = self;
        return view;
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white;
        setupViews()
        setupFirebase()
        myTableView.register(CustomCell.self, forCellReuseIdentifier: Reusable.reuseIdForMain)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}

extension AddPlayerViewController{
    func setupFirebase(){
      //  guard let user = FIRAuth.auth()?.currentUser else {return }
        
        let ref:FIRDatabaseReference = FIRDatabase.database().reference()
        ref.child("players").observe(.childAdded, with: { (snapshot) in
            
            let data = snapshot.value as? Dictionary<String,String>
            let newPlayer = Players(name: data?["name"], imageUrl: data?["imageURL"], otherInfo: data?["otherInfo"], key: snapshot.key)
            self.players.append(newPlayer)
            
            self.myTableView.insertRows(at: [IndexPath(row:self.players.count-1,section:0)], with: .middle)
        })
        
    }
    
    func writeToDb(player:Players){
        
        guard let user = FIRAuth.auth()?.currentUser else { return }
        
        let ref = FIRDatabase.database().reference()
        
        let key = player.key ?? ""
        let name = player.name ?? ""
        let url = player.imageUrl ?? ""
        let info = player.otherInfo ?? ""
        
        
        let data = ["name":name,"otherInfo":info,"imageURL":url]
        ref.child("users").child(user.uid).childByAutoId().setValue(data)
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddPlayerViewController{
    func setupViews(){
        view.addSubview(myTableView)
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
extension AddPlayerViewController:UITableViewDataSource,UITableViewDelegate {
    
    
    //handle tableview stuff here
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Reusable.reuseIdForMain) as! CustomCell
        cell.nameLabel.text = players[indexPath.row].name
        cell.otherInfo.text = players[indexPath.row].otherInfo
        if let urlString = players[indexPath.row].imageUrl,
            let url = URL(string: urlString) {
            cell.profileImage.load.request(with: url)
        }

        //if let url = players[indexPath.row].imageUrl{
          //  cell.profileImage.load.request(with: URL(string:url)!)
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        writeToDb(player: players[indexPath.row])
    }
}
