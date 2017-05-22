//
//  TableViewController.swift
//  Dynamics
//
//  Created by Brandon on 5/22/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var options = ["Snow", "SpaceShip","Flappy Bird"]
    
    override func viewDidLoad() {
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: options[indexPath.row], sender: self)
    }
}
