//
//  ViewController.swift
//  GithubAPI
//
//  Created by Dharamvir on 9/20/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.layer.borderColor = UIColor.blackColor().CGColor
        textField.layer.borderWidth = 0.5
        textField.layer.masksToBounds = true
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", forState: .Normal)
        button.backgroundColor = UIColor.blueColor()
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(searchButtonClicked), forControlEvents: .TouchUpInside)
        return button
    }()
    
    func searchButtonClicked(){
        let controller = ResultTableViewController()
        controller.name = searchTextField.text
        let navController = UINavigationController(rootViewController: controller)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: searchTextField)
        view.addConstraintsWithFormat("V:|-80-[v0(40)]", views: searchTextField)
        
        
        view.addConstraintsWithFormat("H:[v0(400)]", views: searchButton)
        view.addConstraintsWithFormat("V:[v0(40)]", views: searchButton)
        NSLayoutConstraint(item: searchButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: searchButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -100).active = true
        

    }

}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String:  UIView]()
        for (index,view) in views.enumerate(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

