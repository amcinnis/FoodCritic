//
//  NewReviewViewController.swift
//  Food Critic
//
//  Created by Austin McInnis on 3/7/17.
//  Copyright © 2017 Austin McInnis. All rights reserved.
//

import UIKit
import Cosmos

class NewReviewViewController: UIViewController {
    @IBOutlet var restaurantName: UITextField!
    @IBOutlet var rating: CosmosView!
    @IBOutlet var review: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addReview(_ sender: Any) {
    
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
