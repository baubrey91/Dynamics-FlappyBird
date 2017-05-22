//
//  ViewController.swift
//  Dynamics
//
//  Created by Brandon on 5/22/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    @IBOutlet weak var block: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        gravity.addItem(self.block)
        collision.addItem(self.block)
        //collision.collisionDelegate = self
        //collision.addBoundary(withIdentifier: "shelf" as NSCopying, from: CGPoint(x: 0, y: 200), to: CGPoint(x: 150, y: 240))
        collision.translatesReferenceBoundsIntoBoundary = true
        self.gravity.gravityDirection = CGVector(dx: 0, dy: 0.1)
    }

    @IBAction func gravity(_ sender: UIButton) {
        
    }
}

