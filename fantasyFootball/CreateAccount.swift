//
//  CreateAccount.swift
//  fantasyFootball
//
//  Created by Devansh Sharma on 05/07/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit
import Firebase


class CreateAccount: UIViewController {
    
    var name:UITextField = {
        
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = UITextAutocorrectionType.no
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.autocapitalizationType = .none
        view.placeholder = "Whats your name?"
        return view

    }()
    
    var emailID:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = UITextAutocorrectionType.no
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.autocapitalizationType = .none
        view.placeholder = "Whats your email?"
        return view
    
    }()
    
    
    var pass:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = UITextAutocorrectionType.no
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.autocapitalizationType = .none
        view.placeholder = "Enter strong password"
        return view
        
    }()
    
    
    var dato:UITextField = {
        
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = UITextAutocorrectionType.no
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.autocapitalizationType = .none
        view.placeholder = "When is your Birthday?"
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        view.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        return view
        
        
        
    }()

    var gender:UISegmentedControl = {
        let view = UISegmentedControl(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insertSegment(withTitle: "Male", at: 0, animated: true)
        view.insertSegment(withTitle: "Female", at: 1, animated: true)
        return view
        
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismiss")
        
        view.addGestureRecognizer(tap)
    
        view.backgroundColor = .white
       
        setupviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func dismiss() {
        
        view.endEditing(true)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dato.text = dateFormatter.string(from: sender.date)
    }
    

    
    
    func signIn(){
        
        if let email = emailID.text, let password = pass.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{self.log()}
                else{self.log()}
            })
        }
        
        
    }





func log(){
    
    FIRAuth.auth()?.signIn(withEmail: emailID.text!, password: pass.text!, completion: {
        
        user, error in
        
        if error != nil {
            
            self.emailID.placeholder = "Incorrect Email"
            self.pass.placeholder = "Enter password"
            self.emailID.text = ""
            self.pass.text = ""
        }
            
        else {
            let vc = UINavigationController(rootViewController: MainViewController())
            self.present(vc, animated: true, completion: nil)
           
        }
    })
}

    /*func handleinfo(){
        
        if let name = name.text,let DOB = dato.text, let gender = {
            ref = FIRDatabase.database().reference()
            
            
            let value = ["name":name,"imageURL":url,"otherInfo":other]
            ref.child("userinfo").childByAutoId().setValue(value)
        }
        
    }*/


    func bACK(){
    dismiss(animated: true, completion: nil)
        
    }
    
    func setupviews(){
        view.addSubview(name)
        view.addSubview(emailID)
        view.addSubview(pass)
        view.addSubview(gender)
        view.addSubview(dato)
        
        /*
 emailField.leftAnchor.constraint(equalTo: view.leftAnchor,constant:30).isActive = true
 emailField.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-30).isActive = true
 emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
 emailField.topAnchor.constraint(equalTo: view.topAnchor,constant:50).isActive = true*/

        name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        name.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        name.heightAnchor.constraint(equalToConstant: 35).isActive = true
        emailID.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        emailID.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        emailID.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        emailID.heightAnchor.constraint(equalToConstant: 35).isActive = true
        pass.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pass.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pass.topAnchor.constraint(equalTo: emailID.bottomAnchor, constant: 15).isActive = true
        pass.heightAnchor.constraint(equalToConstant: 35).isActive = true
        gender.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        gender.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        gender.topAnchor.constraint(equalTo: pass.bottomAnchor, constant: 15).isActive = true
        gender.heightAnchor.constraint(equalToConstant: 35).isActive = true
        dato.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        dato.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dato.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 15).isActive = true
        dato.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
      
        let button = UIBarButtonItem(title: "< Sign In", style: .plain, target: self, action: #selector(bACK))
        self.navigationItem.leftBarButtonItems = [button]

        
    }
    
    
    

}
