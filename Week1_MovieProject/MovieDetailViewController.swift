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
    @IBOutlet weak var detailCloseButton: UIButton!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionContainerView: UIView!
    
    var imageData: Data!
    var movieDescription: String!
    var movieTitle: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = movieTitle
        movieDetailImageView.image = UIImage(data: imageData)
        movieDescriptionLabel.text = movieDescription
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailCloseButton.layer.borderWidth = CGFloat(3.0)
        detailCloseButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).cgColor
        detailCloseButton.layer.cornerRadius = CGFloat(detailCloseButton.frame.height / 2)
    }
    
    @IBAction func closeButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
