//
//  ReviewsTableViewController.swift
//  
//
//  Created by Austin McInnis on 3/7/17.
//
//

import UIKit
import Cosmos
import Firebase

class UserCell: UITableViewCell {
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var reviewsCountLabel: UILabel!
    
}

class ReviewCell: UITableViewCell {
    
    @IBOutlet var restaurantLabel: UILabel!
    @IBOutlet var rating: CosmosView!
}

class ReviewsTableViewController: UITableViewController {

    private var database = FIRDatabase.database().reference()
    private var reviews = [FIRDataSnapshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let reviewsRef = database.child("reviews")
        
        reviewsRef.observe(.childAdded, with: {
            [weak self] (snapshot) in
            guard let this = self else { return }
            this.reviews.append(snapshot)
            this.tableView.insertRows(at: [IndexPath(row: this.reviews.count-1, section: 1)], with: .automatic)
        })
        
        reviewsRef.observe(.childRemoved, with: {
            [weak self] (snapshot) in
            guard let this = self else { return }
            let id = snapshot.value as! String
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        return 0
    }

    @IBAction func addReview(_ sender: Any) {
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
            cell.imageView?.image = UIImage(named: "batman.jpg")
            cell.nameLabel.text = "Austin McInnis"
            cell.reviewsCountLabel.text = "3 Reviews"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
            
            return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
