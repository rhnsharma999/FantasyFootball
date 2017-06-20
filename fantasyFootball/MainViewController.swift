//
//  MainViewController.swift
//  fantasyFootball
//
//  Created by Rohan Lokesh Sharma on 20/06/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var myTableView:UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.delegate = self;
        view.dataSource = self;
        return view;
    }()

    override func viewDidLoad() {
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Reusable.reuseIdForMain) as! CustomCell
        cell.nameLabel.text = "Rohan Sharma"
        cell.otherInfo.text = "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec sed odio dui. Aenean lacinia bibendum nulla sed consectetur. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Maecenas faucibus mollis interdum."
        //cell?.textLabel?.text = "Some shit"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
        self.navigationItem.rightBarButtonItem = button
    }
    
    func addPlayer(){
        print("this will move to a new vc to add a new player")
    }
    
}
