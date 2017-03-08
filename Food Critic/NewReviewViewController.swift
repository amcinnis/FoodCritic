//
//  NewReviewViewController.swift
//  Food Critic
//
//  Created by Austin McInnis on 3/7/17.
//  Copyright © 2017 Austin McInnis. All rights reserved.
//

import UIKit
import Cosmos
import Firebase
import FirebaseDatabase

class NewReviewViewController: UIViewController, UITextFieldDelegate {
    
    private var databaseRef = FIRDatabase.database().reference()
    
    @IBOutlet var restaurantName: UITextField!
    @IBOutlet var cosmos: CosmosView!
    @IBOutlet var review: UITextField!
    @IBOutlet weak var addReviewButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantName.delegate = self
        review.delegate = self
        restaurantName.addTarget(self, action: #selector(NewReviewViewController.valuesChanged), for: .editingChanged)
        review.addTarget(self, action: #selector(NewReviewViewController.valuesChanged), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addReview(_ sender: Any) {
        let reviewsRef = databaseRef.child("reviews")
        let reviewRef = reviewsRef.childByAutoId()
        reviewRef.child("name").setValue(restaurantName.text!)
        reviewRef.child("rating").setValue(cosmos.rating)
        reviewRef.child("description").setValue(review.text!)
        dismiss(animated: true, completion: nil)
    }

    func valuesChanged() {
        if !(restaurantName.text?.isEmpty)! && !(review.text?.isEmpty)! && cosmos.rating > 0 {
            addReviewButton.isEnabled = true
        }
        else {
            addReviewButton.isEnabled = false
        }
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
