//
//  GameViewController.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ConfigurationViewDelegate {
    
    // MARK: game logic state
    var gameModel:GameModel = GameModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // callback method for configuration view controller
    func playerConfiguredGame() {
        // how to respond to game config changes?
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "configSegue" {
            let configViewController:ConfigurationViewController = segue.destination as! ConfigurationViewController;
            configViewController.delegate = self;
        }
    }
    
    @IBAction func configButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier:"configSegue", sender:self);
    }
    
}
