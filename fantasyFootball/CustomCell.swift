//
//  CustomCell.swift
//  fantasyFootball
//
//  Created by Rohan Lokesh Sharma on 20/06/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    var profileImage:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true;
        view.image = #imageLiteral(resourceName: "cisco")
        return view;
    }()
    
    var nameLabel:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }()

    var otherInfo:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.isEditable = false;
        view.isSelectable = false;
        view.isScrollEnabled = false;
        return view;
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension CustomCell {
    
    func setupViews(){
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(otherInfo)
        profileImage.leftAnchor.constraint(equalTo: leftAnchor,constant:15).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.topAnchor.constraint(equalTo: topAnchor,constant:15).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor,constant:10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor,constant:-10).isActive = true
     //   nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.sizeToFit() // this is used to automatically set the height of the laberl according to the font
        nameLabel.topAnchor.constraint(equalTo: topAnchor,constant:10).isActive = true
        
        otherInfo.leftAnchor.constraint(equalTo: profileImage.rightAnchor,constant:10).isActive = true
        otherInfo.rightAnchor.constraint(equalTo: rightAnchor,constant:-10).isActive = true
        otherInfo.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:10).isActive = true
        otherInfo.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-10).isActive = true
        
        
    }
}
