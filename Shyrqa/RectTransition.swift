//
//  RectTransition.swift
//  Shyrqa
//
//  Created by Алпамыс on 30.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit

class RectTransition: NSObject {

    var rect = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            rect.center = startingPoint
        }
    }
    
    var rectColor = UIColor.blue
    var duration = 0.3
    
    enum RectTranstionMode: Int {
        case present, dismiss, pop
    }
    
    var transitionMode: RectTranstionMode = .present
}

extension RectTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: .to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
//                rect = UIView()
                rect.frame = frameForRect(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
//                rect.layer.cornerRadius = rect.frame.size.height / 2
                rect.center = startingPoint
                rect.backgroundColor = rectColor
                rect.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(rect)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: { 
                    self.rect.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { (success) in
                    transitionContext.completeTransition(success)
                })            }
        } else {
             
        }
    }
    
    func frameForRect(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
