//
//  ReviewViewController.swift
//  Food Critic
//
//  Created by Austin McInnis on 3/7/17.
//  Copyright © 2017 Austin McInnis. All rights reserved.
//

import UIKit
import Cosmos

class ReviewViewController: UIViewController {

    var review: Review?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cosmos: CosmosView!
    @IBOutlet var descriptionLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        
        if let review = review {
            nameLabel.text = review.name
            cosmos.rating = Double(review.rating!)
            descriptionLabel.text = review.description
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
