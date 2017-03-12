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
import FirebaseDatabase

class UserCell: UITableViewCell {
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var reviewsCountLabel: UILabel!
    
}

class ReviewCell: UITableViewCell {
    
    var review: Review?
    @IBOutlet var restaurantLabel: UILabel!
    @IBOutlet var cosmos: CosmosView!
}

class ReviewsTableViewController: UITableViewController {

    private var database: FIRDatabaseReference!
    private var reviews = [Review]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredReviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        //Firebase
        database = FIRDatabase.database().reference()
        
        let reviewsRef = database.child("reviews")
        
        reviewsRef.observe(.childAdded, with: {
            [weak self] (snapshot) in
            guard let this = self else { return }
//            this.reviews.append(snapshot)
            let review = Review()
            review.id = snapshot.key
            if let name = snapshot.childSnapshot(forPath: "name").value as? String {
                review.name = name
            }
            if let rating = snapshot.childSnapshot(forPath: "rating").value as? Int {
                review.rating = rating
            }
            if let desc = snapshot.childSnapshot(forPath: "description").value as? String {
                review.description = desc
            }
            this.reviews.append(review)
            this.tableView.insertRows(at: [IndexPath(row: this.reviews.count-1, section: 1)], with: .automatic)
        })
        
        reviewsRef.observe(.childRemoved, with: {
            [weak self] (snapshot) in
            guard let this = self else { return }
            let id = snapshot.key
            for (i, review) in this.reviews.enumerated() {
                if review.id == id {
                    this.reviews.remove(at: i)
                    this.tableView.deleteRows(at: [IndexPath(row:i, section: 1)], with: .automatic)
                    break
                }
            }
        })
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredReviews = reviews.filter {
            (review) in
            return (review.name?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
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
        else {
            if searchController.isActive && !(searchController.searchBar.text?.isEmpty)! {
                return filteredReviews.count
            }
            return reviews.count
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            
            let review: Review
            if searchController.isActive && !(searchController.searchBar.text?.isEmpty)! {
                review = filteredReviews[indexPath.row]
            }
            else {
                review = reviews[indexPath.row]
            }
            
            cell.review = review
            cell.restaurantLabel.text = review.name
            cell.cosmos.rating = Double(review.rating!)
            
            return cell
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detail" {
            if let nav = segue.destination as? UINavigationController {
                if let dest = nav.topViewController as? ReviewViewController {
                    if let cell = sender as? ReviewCell {
                        if let review = cell.review {
                            dest.review = review
                        }
                    }
                }
            }
        }
    }
 
}

extension ReviewsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
