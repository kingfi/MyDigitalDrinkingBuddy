//
//  TableViewController.swift
//  Olayeni
//
//  Created by Fianko Buckle on 12/4/19.
//  Copyright © 2019 Fianko Buckle. All rights reserved.
//

import UIKit
import CoreData
import Parse

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tbView: UITableView!
    
    var drinks: [Drink] = []
    var searchedDrinks: [Drink] = []
    
    func capitalize(text: String) -> String  {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configureFetchedResultsController()
        drinks = fetchedResultsController?.fetchedObjects as! [Drink]
        searchedDrinks = drinks
        tbView.dataSource = self
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText == ""{
            searchedDrinks = drinks
        }else{
            searchedDrinks.removeAll()
            for drink in  drinks{
                if (drink.brand?.lowercased().contains(searchText.lowercased()))!{
                    searchedDrinks.append(drink)
                }
            }
        }
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    private func configureFetchedResultsController(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Drink")
        let sortDescriptor = NSSortDescriptor(key: "brand", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self as! NSFetchedResultsControllerDelegate
        
        do{
            try fetchedResultsController?.performFetch()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    


    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
     */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let sections = fetchedResultsController?.sections else {
//            return 0
//        }
//
//        let rowCount = sections[section].numberOfObjects
//        print("THE AMOUNT OF ROWS IN THE SECTION ARE: \(rowCount)")
        let rowCount = searchedDrinks.count
        
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
        
//        if let drink = fetchedResultsController?.object(at: indexPath) as? Drink{
//            cell.textLabel?.text = drink.brand
//        }
        if let drink = searchedDrinks[indexPath.row] as? Drink{
            cell.textLabel?.text = drink.brand
        }

        // Configure the cell...

        return cell
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alcoholSegue" {
            if let destination = segue.destination as? alcoholViewController {
                destination.drink = searchedDrinks[tableView.indexPathForSelectedRow!.row]
                
            }
        }
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
extension TableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("THE CONTROLLER CONTENT HAS CHANGED")
        tbView.reloadData()
    }
}


