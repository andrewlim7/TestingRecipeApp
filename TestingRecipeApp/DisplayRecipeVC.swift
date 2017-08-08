//
//  DisplayRecipeVC.swift
//  TestingRecipeApp
//
//  Created by Andrew Lim on 03/08/2017.
//  Copyright © 2017 Andrew Lim. All rights reserved.
//

import UIKit

class DisplayRecipeVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var getRecipe : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = getRecipe?.title
        
        categoryLabel.text = getRecipe?.category
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
