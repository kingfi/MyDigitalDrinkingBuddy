//
//  DiaryViewController.swift
//  Olayeni
//
//  Created by Fianko Buckle on 12/6/19.
//  Copyright © 2019 Fianko Buckle. All rights reserved.
//

import UIKit
import Parse

class DiaryViewController: UITableViewController {

    @IBOutlet var tbView: UITableView!
    
    let defaults = UserDefaults.standard
    
    var entries: [PFObject] = []
    
    let myRefreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.dataSource = self
        getEntries()
        
        myRefreshControl.addTarget(self, action: #selector(getEntries), for: .valueChanged)
        tbView.refreshControl = myRefreshControl

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //gets list of entries associated with user using PFQuery API
    @objc func getEntries(){
        self.entries.removeAll()
        let query = PFQuery(className:"DiaryEntries")
        query.whereKey("userId", equalTo: defaults.string(forKey: "objectId"))
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    self.entries.append(object)
                    
                }
            }
            self.tbView.reloadData()
            self.myRefreshControl.endRefreshing()
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    //displays diary entries in table format
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("count: ")
        print(entries.count)
        return entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath)

         //Configure the cell...
        if let entry = entries[entries.count-indexPath.row-1] as? PFObject{
            let brand = entry["brand"] as! String
            let amount = entry["amt"] as! String
            let date = entry["date"] as! String
            cell.textLabel?.text = "" + date + " " + brand + " " + amount + " shots"
            
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
