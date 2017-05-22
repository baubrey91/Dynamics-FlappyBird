//
//  FlappyBirdViewController.swift
//  Dynamics
//
//  Created by Brandon on 5/22/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit

class FlappyBirdViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var bird: UIImageView!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var pipeItemBehavior: UIDynamicItemBehavior!
    var birdItemBehavior: UIDynamicItemBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        pipeItemBehavior = UIDynamicItemBehavior()
        birdItemBehavior = UIDynamicItemBehavior()
        
        collision.collisionDelegate = self
        gravity.gravityDirection = CGVector(dx: 0, dy: 0.25)

        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(pipeItemBehavior)
        animator.addBehavior(birdItemBehavior)
        
        gravity.addItem(bird)
        collision.addItem(bird)
        
        birdItemBehavior.addItem(bird)
        
        addPipe()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.addPipe), userInfo: nil, repeats: true)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:))))
    }
    
    func didTap(_ gesture: UIGestureRecognizer) {
        birdItemBehavior.addLinearVelocity(CGPoint(x: 0,y: -100), for: self.bird)
    }
    
    func addPipe() {
        
        let rand = arc4random_uniform(3)
        var offset:CGFloat = 0
        switch rand {
        case 0:
            offset = 50
        
        case 1:
            offset = 100
        default :
            offset = 150
    }

        let pipeTopView = UIImageView(image: UIImage(named: "pipeTop"))
        self.view.addSubview(pipeTopView)
        let pipeBottomView = UIImageView(image: UIImage(named: "pipeBottom"))
        self.view.addSubview(pipeBottomView)
        
        pipeTopView.center.y = 0 + offset
        pipeTopView.center.x = view.bounds.width
        pipeBottomView.center.y = view.bounds.height - 150 + offset
        pipeBottomView.center.x = view.bounds.width
        pipeItemBehavior.addItem(pipeTopView)
        pipeItemBehavior.addItem(pipeBottomView)
        collision.addItem(pipeTopView)
        collision.addItem(pipeBottomView)
        pipeItemBehavior.addLinearVelocity(CGPoint(x: -200,y: 0), for: pipeTopView)
        pipeItemBehavior.addLinearVelocity(CGPoint(x: -200,y: 0), for: pipeBottomView)
    }

}
