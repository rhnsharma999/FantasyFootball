//
//  MainViewController.swift
//  fantasyFootball
//
//  Created by Rohan Lokesh Sharma on 20/06/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit
import FirebaseDatabase
class MainViewController: UIViewController {
    
    var players = [Players]()
    
    lazy var myTableView:UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.delegate = self;
        view.dataSource = self;
        return view;
    }()

    override func viewDidLoad() {
        setupFIrebase()
        super.viewDidLoad()
        setupViews()
        self.navigationItem.title = "My Players"
        myTableView.register(CustomCell.self, forCellReuseIdentifier: Reusable.reuseIdForMain)
        view.backgroundColor = .white;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension MainViewController:UITableViewDataSource,UITableViewDelegate {
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension MainViewController{
    
    func setupFIrebase(){
        let ref:FIRDatabaseReference = FIRDatabase.database().reference()
        ref.child("players").observe(.childAdded, with: { (snapshot) in
        
        let data = snapshot.value as? Dictionary<String,String>
        let newPlayer = Players(name: data?["name"], imageUrl: data?["imageURL"], otherInfo: data?["otherInfo"], key: snapshot.key)
        self.players.append(newPlayer)
            
            self.myTableView.insertRows(at: [IndexPath(row:self.players.count-1,section:0)], with: .middle)
            
            
        
        })
    }
}

extension MainViewController{
    
    func setupViews(){
        view.addSubview(myTableView)
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayer))
        let button1 = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(goToCreatePlayer))
        self.navigationItem.rightBarButtonItems = [button,button1]
    }
    
    func goToCreatePlayer(){
        present(UINavigationController(rootViewController:createPlayerViewController()), animated: true, completion: nil)
    }
    func addPlayer(){
        print("this will move to a new vc to add a new player")
    }
    
}
