//
//  MovieCell.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/17/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

final class MovieCell: UITableViewCell {
    var imageUrl: String!
    var imageData: Data!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!   
}
