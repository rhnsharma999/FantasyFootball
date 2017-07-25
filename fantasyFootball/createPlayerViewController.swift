//
//  createPlayerViewController.swift
//  fantasyFootball
//
//  Created by Rohan Lokesh Sharma on 20/06/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit
import FirebaseDatabase
class createPlayerViewController: UIViewController {
    
    
    var nameField:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.autocorrectionType = UITextAutocorrectionType.no
        view.autocapitalizationType = .none
        view.placeholder = "Enter name"
        return view
    }()
    
    var imageURLField:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Enter url"
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.autocorrectionType = UITextAutocorrectionType.no
        view.autocapitalizationType = .none
        return view
    }()
    
    var sendButton:UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.setTitle("Upload", for: .normal)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view;
    }()
    
    var otherInfo:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.isScrollEnabled = false;
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.autocorrectionType = UITextAutocorrectionType.no
        view.autocapitalizationType = .none
        return view;
        
    }()
    
    var ref:FIRDatabaseReference!
    

    override func viewDidLoad() {
        setupFields()
        setupButtons()
        view.backgroundColor = .white
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension createPlayerViewController{
    func handleWrite(){
        
        if let name = nameField.text,let url = imageURLField.text, let other = otherInfo.text{
            ref = FIRDatabase.database().reference()
            
            
            let value = ["name":name,"imageURL":url,"otherInfo":other]
            ref.child("players").childByAutoId().setValue(value)
        }
        
    }
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension createPlayerViewController {
    
    
    //handle ui setup here
    
    func setupFields(){
        view.addSubview(nameField)
        view.addSubview(imageURLField)
        view.addSubview(otherInfo)
        
        nameField.leftAnchor.constraint(equalTo: view.leftAnchor,constant:30).isActive = true
        nameField.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-30).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameField.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,constant:50).isActive = true
        
        imageURLField.leftAnchor.constraint(equalTo: view.leftAnchor,constant:30).isActive = true
        imageURLField.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-30).isActive = true
        imageURLField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageURLField.topAnchor.constraint(equalTo: nameField.bottomAnchor,constant:30).isActive = true
        
        otherInfo.leftAnchor.constraint(equalTo: view.leftAnchor,constant:30).isActive = true
        otherInfo.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-30).isActive = true
        otherInfo.topAnchor.constraint(equalTo: imageURLField.bottomAnchor,constant:10).isActive = true
        otherInfo.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupButtons(){
        view.addSubview(sendButton)
        sendButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.topAnchor.constraint(equalTo: otherInfo.bottomAnchor,constant:30).isActive = true
        
        sendButton.addTarget(self, action: #selector(handleWrite), for: .touchUpInside)
        
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = button
    }
    
   
}
