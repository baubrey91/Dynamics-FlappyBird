//
//  SnowViewController.swift
//  Dynamics
//
//  Created by Brandon on 5/22/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class SnowViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        collision.addBoundary(withIdentifier: "shelf" as NSCopying, from: CGPoint(x: 0, y: 200), to: CGPoint(x: 150, y: 240))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        collision.collisionDelegate = self
        
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.generateSnow), userInfo: nil, repeats: true)
    }
    
    func generateSnow() {
        
        let max = self.view.bounds.maxX
        let rand = arc4random_uniform(UInt32(max))
        let snow = UIView(frame: CGRect(x: Int(rand), y: 50, width: 10, height: 10))
        snow.backgroundColor = UIColor.white
        self.view.addSubview(snow)
        gravity.addItem(snow)
        collision.addItem(snow)
    }
    
    func meltSnow(snowView: UIView) {
        UIView.animate(withDuration: 1.0, animations: {
            snowView.alpha = 0.0
        }, completion: { (bool: Bool) -> Void in
            self.collision.removeItem(snowView)
            self.gravity.removeItem(snowView)
            snowView.removeFromSuperview()
        })
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.meltSnow(snowView: item as! UIView)
        }

    }
}
