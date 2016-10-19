//
//  UIViewExtension.swift
//  Week1_MovieProject
//
//  Created by Arturo Fernandez on 10/17/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addSubviewInContainerView(subView: UIView) {
        self.addSubview(subView)
        
        var viewBindingDict = [String: AnyObject]()
        viewBindingDict["subView"] = subView
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: viewBindingDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: [], metrics: nil, views: viewBindingDict))
    }
}
