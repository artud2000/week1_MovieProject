//
//  MovieDetailViewController.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/18/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieDetailImageView: UIImageView!
    var imageData: Data!
    var movieDescription: String!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionContainerView: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieDetailImageView.image = UIImage(data: imageData)
        movieDescriptionLabel.text = movieDescription
    }
}
