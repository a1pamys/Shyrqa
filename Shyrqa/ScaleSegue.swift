//
//  ScaleSegue.swift
//  Shyrqa
//
//  Created by Алпамыс on 30.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {

    
    override func perform() {
        scale()
    }
    
    func scale(){
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration:  0.3, delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }) { (success) in
            fromViewController.present(toViewController, animated: false, completion: nil)
        }
    }
    
}
