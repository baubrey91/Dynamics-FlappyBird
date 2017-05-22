//
//  SpaceShipViewController.swift
//  Dynamics
//
//  Created by Brandon on 5/22/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class SpaceShipViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var push: UIPushBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        push = UIPushBehavior(items: [], mode: UIPushBehaviorMode.continuous)
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(push)
        
        collision.collisionDelegate = self
        
        self.gravity.gravityDirection = CGVector(dx: 0, dy: 0.4)
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.generateSpaceShip), userInfo: nil, repeats: true)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.fireAway(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
        
        self.push.pushDirection = CGVector(dx: 0,dy: -1)
    }
    
    func generateSpaceShip() {
        
        let max = self.view.bounds.maxX
        let rand = arc4random_uniform(UInt32(max));
        let ship = UIImageView(image: #imageLiteral(resourceName: "spaceShip"))
        self.view.addSubview(ship)
        ship.center.x = CGFloat(rand)
        gravity.addItem(ship)
        collision.addItem(ship)
    }
    
    func fireAway(_ tap: UITapGestureRecognizer) {
        let location = tap.location(in: self.view)

        let missile = UIView(frame: CGRect(x: location.x, y: location.y, width: 10, height: 10))
        missile.backgroundColor = UIColor.black
        self.view.addSubview(missile)
        collision.addItem(missile)
        push.addItem(missile)
        print(push)
        print(push.pushDirection)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
       
        (item1 as! UIView).removeFromSuperview()
        (item2 as! UIView).removeFromSuperview()
    }
}
