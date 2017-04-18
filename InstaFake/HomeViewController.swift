//
//  HomeViewController.swift
//  InstaFake
//
//  Created by my mac on 4/1/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts : [PFObject]?

    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        //Dismiss the keyboard when user taps off the screen
        view.endEditing(true)
        print("onTap called!!!")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //Let the view controller be the delegate and data source
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier:
        "headerView")
        updateHome()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateHome()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        }
        
        return 0
    }
    
    
    
   /* public func numberOfSections(in tableView: UITableView) -> Int {
        
        print("number of sections called!")
        if let posts = posts{
            return posts.count
        }
        return 0
    }*/
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        print("called header for function")
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView")! as UITableViewHeaderFooterView
        
        //Get the user who posted the image
        let post = posts?[section]
        //Get the username
        let user = post?["author"] as! PFUser
        let username = user.username
        //Put the username in the header
        header.textLabel?.text = username as! String?
        
        return header
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
  
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as! HomeScreenCell
        
        cell.instaFakePost = posts?[indexPath.section]
        return cell
    }
    
    func updateHome(){
        //Construct a PFQuery
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        //Fetch the data aysnchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                //Update the posts
                self.posts = posts
            }else{
                print("Unable to fetch the data")
                print(error?.localizedDescription)
                
            }
        }
        //Update the tableview based off the new data
        self.tableView.reloadData()
    
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
