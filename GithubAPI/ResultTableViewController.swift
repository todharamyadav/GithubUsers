//
//  ResultTableViewController.swift
//  GithubAPI
//
//  Created by Dharamvir on 9/20/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    var name: String?
    var array = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(dismiss))
        
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = name
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
       if let userName = name{
            print(userName)
            let url = "https://api.github.com/users/\(userName)/repos"
            print(url)
            getContactListJSON(url)
        }
    }
    
    func dismiss(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        cell.textLabel!.text = array[indexPath.row] as? String
        return cell
    }
    
    func getContactListJSON(url: String){
        let mySession = NSURLSession.sharedSession()
        if let url: NSURL = NSURL(string: url){
            let networkTask = mySession.dataTaskWithURL(url, completionHandler : {data, response, error -> Void in
                
                do {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
                    
                    let results: NSArray = jsonData.valueForKey("name") as! NSArray
                    print(results)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.array = results
                        self.tableView!.reloadData()
                    })
                    
                } catch {
                    // handle error
                }
                
            })
            networkTask.resume()

        }else{
            let alert = UIAlertController(title: "Error", message: "No repository found or User dont exist", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction) -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
            })
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action: UIAlertAction) -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
            })
            alert.addAction(ok)
            alert.addAction(cancel)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
