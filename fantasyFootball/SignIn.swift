//
//  ViewController.swift
//  fantasyFootball
//
//  Created by Rohan Lokesh Sharma on 20/06/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var emailField:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.keyboardType = UIKeyboardType.emailAddress
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(red: 123/255, green: 213/255, blue: 250/255, alpha: 1.0).cgColor
        view.autocorrectionType = UITextAutocorrectionType.no
        view.autocapitalizationType = .none
        view.placeholder = "Enter email"
        return view
    }()
    
    var passField:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.isSecureTextEntry = true
        view.placeholder = "Enter Password"
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 123/255, green: 213/255, blue: 250/255, alpha: 1.0).cgColor
        view.autocorrectionType = UITextAutocorrectionType.no
        view.autocapitalizationType = .none
        return view
    }()
    
    var SignInButton:UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.layer.cornerRadius = 50
        view.backgroundColor = .white
        view.setTitle("Sign In", for: .normal)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 123/255, green: 213/255, blue: 250/255, alpha: 1.0).cgColor
        return view;
    }()
    
    var CreateAcc:UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 50
        view.backgroundColor = .white
        view.setTitle("Sign Up", for: .normal)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 123/255, green: 213/255, blue: 250/255, alpha: 1.0).cgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        setupButtons()
        view.backgroundColor = UIColor(red: 115/255, green: 150/255, blue: 211/255, alpha: 1.0)
;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    //handle sign in stuff here
    
    
    func signIn(){
        
        if let email = emailField.text, let password = passField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                    //print(error?.localizedDescription)
                    if let msg = error?.localizedDescription{
                        self.showError(msg: msg)
                    }
                }
                else{
                    let vc = UINavigationController(rootViewController: MainViewController())
                    self.present(vc, animated: true, completion: nil)
                }
            })
        }
        
        
    }
    
 
    func createacc(){
        present(UINavigationController(rootViewController:CreateAccount()), animated: true, completion: nil)

    }
    
}

extension ViewController {
    
    
    //handle ui setup here
    
    func setupFields(){
        view.addSubview(emailField)
        view.addSubview(passField)
        
        emailField.leftAnchor.constraint(equalTo: view.leftAnchor,constant:30).isActive = true
        emailField.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-30).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailField.topAnchor.constraint(equalTo: view.topAnchor,constant:50).isActive = true
        
        passField.leftAnchor.constraint(equalTo: view.leftAnchor,constant:30).isActive = true
        passField.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-30).isActive = true
        passField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passField.topAnchor.constraint(equalTo: emailField.bottomAnchor,constant:30).isActive = true
    }
    
    func setupButtons(){
        view.addSubview(SignInButton)
        view.addSubview(CreateAcc)
        SignInButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        SignInButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        SignInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 75).isActive = true
        SignInButton.topAnchor.constraint(equalTo: passField.bottomAnchor,constant:30).isActive = true
        
        CreateAcc.heightAnchor.constraint(equalToConstant: 100).isActive = true
        CreateAcc.widthAnchor.constraint(equalToConstant: 100).isActive = true
        CreateAcc.leftAnchor.constraint(equalTo: SignInButton.rightAnchor, constant: 20).isActive = true
        CreateAcc.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 30).isActive = true
        CreateAcc.addTarget(self, action: #selector(createacc), for: .touchUpInside)

        SignInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    func showError(msg:String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

